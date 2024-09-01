import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:math';
import 'questions.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  StreamController<int> selected = StreamController<int>();
  List<String> items = ['Matemáticas', 'Historia', 'Ciencias', 'Lenguaje', 'Geografía', 'Arte'];
  int selectedIndex = -1;
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _decorController;
  late Animation<double> _decorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _decorController = AnimationController(duration: const Duration(seconds: 10), vsync: this)..repeat();
    _decorAnimation = CurvedAnimation(parent: _decorController, curve: Curves.linear);
  }

  @override
  void dispose() {
    selected.close();
    _controller.dispose();
    _decorController.dispose();
    super.dispose();
  }

  void _spinWheel() {
    setState(() {
      selectedIndex = Fortune.randomInt(0, items.length);
      selected.add(selectedIndex);
    });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edu-Ruleta Mágica', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple[300]!, Colors.blue[200]!],
          ),
        ),
        child: Stack(
          children: [
            // Elementos decorativos
            ...List.generate(10, (index) => _buildFloatingObject(index)),

            // Contenido principal
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ScaleTransition(
                      scale: _animation,
                      child: FortuneWheel(
                        selected: selected.stream,
                        animateFirst: false,
                        physics: CircularPanPhysics(
                          duration: Duration(seconds: 1),
                          curve: Curves.decelerate,
                        ),
                        onFling: _spinWheel,
                        items: [
                          for (var item in items)
                            FortuneItem(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                              ),
                              style: FortuneItemStyle(
                                color: Colors.primaries[items.indexOf(item) % Colors.primaries.length],
                                borderWidth: 3,
                                borderColor: Colors.white,
                              ),
                            ),
                        ],
                        onAnimationEnd: () {
                          if (selectedIndex != -1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuestionPage(
                                  question: getRandomQuestionByCategory(items[selectedIndex]),
                                  onReturnToWheel: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => GameScreen()),
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                    child: Text('¡Girar la Ruleta Mágica!', style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                      onPrimary: Colors.purple[900],
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _spinWheel,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingObject(int index) {
    final random = Random(index);
    final size = random.nextInt(30) + 20.0;
    final icons = [Icons.book, Icons.create, Icons.school, Icons.lightbulb, Icons.psychology];
    final icon = icons[random.nextInt(icons.length)];

    return AnimatedBuilder(
      animation: _decorAnimation,
      builder: (context, child) {
        return Positioned(
          left: random.nextDouble() * MediaQuery.of(context).size.width,
          top: (random.nextDouble() * MediaQuery.of(context).size.height - size) *
              (1 + sin((_decorAnimation.value + random.nextDouble()) * 2 * pi)) / 2,
          child: Opacity(
            opacity: 0.7,
            child: Icon(icon, size: size, color: Colors.white),
          ),
        );
      },
    );
  }
}

// Widget de la página de preguntas
class QuestionPage extends StatefulWidget {
  final Question question;
  final VoidCallback onReturnToWheel;

  QuestionPage({required this.question, required this.onReturnToWheel});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int? selectedAnswerIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: widget.onReturnToWheel,
        ),
        title: Text(
          widget.question.category,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: _getCategoryColor(widget.question.category),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_getCategoryColor(widget.question.category), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.question.questionText,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ...widget.question.options.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      child: Text(
                        entry.value,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: _getOptionColor(entry.key),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () => _checkAnswer(entry.key),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _checkAnswer(int index) {
    setState(() {
      selectedAnswerIndex = index;
    });

    bool isCorrect = index == widget.question.correctAnswerIndex;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            isCorrect ? '¡Correcto!' : 'Ooops...',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isCorrect ? Colors.green : Colors.red,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isCorrect ? Icons.celebration : Icons.sentiment_very_dissatisfied,
                size: 80,
                color: isCorrect ? Colors.yellow : Colors.blue,
              ),
              SizedBox(height: 20),
              Text(
                isCorrect
                    ? '¡Genial! Eres muy inteligente.'
                    : 'No te preocupes, ¡sigue intentando!',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Siguiente pregunta', style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.of(context).pop();
                widget.onReturnToWheel();
              },
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
        );
      },
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Matemáticas':
        return Colors.blue[400]!;
      case 'Historia':
        return Colors.orange[400]!;
      case 'Ciencias Naturales':
        return Colors.green[400]!;
      case 'Lenguaje':
        return Colors.purple[400]!;
      case 'Geografía':
        return Colors.teal[400]!;
      case 'Arte':
        return Colors.pink[400]!;
      default:
        return Colors.red[400]!;
    }
  }

  Color _getOptionColor(int index) {
    List<Color> colors = [
      Colors.red[300]!,
      Colors.blue[300]!,
      Colors.green[300]!,
      Colors.orange[300]!,
    ];
    return colors[index % colors.length];
  }
}