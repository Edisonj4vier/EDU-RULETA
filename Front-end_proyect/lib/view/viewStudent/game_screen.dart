import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';
import 'questions.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  StreamController<int> selected = StreamController<int>();
  List<String> items = [
    'Matemáticas',
    'Historia',
    'Ciencias Naturales',
    'Lenguaje',
    'Geografía',
    'Arte'
  ];
  int selectedIndex = 0;

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  void _spinWheel() {
    setState(() {
      selectedIndex = Fortune.randomInt(0, items.length);
      selected.add(selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edu-Ruleta'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FortuneWheel(
              selected: selected.stream,
              items: [
                for (var item in items) FortuneItem(child: Text(item)),
              ],
              onAnimationEnd: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionPage(
                      question: getRandomQuestionByCategory(items[selectedIndex]),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: ElevatedButton(
              child: Text('Girar'),
              onPressed: _spinWheel,
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionPage extends StatelessWidget {
  final Question question;

  QuestionPage({required this.question});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(question.category),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question.questionText,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...question.options.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  child: Text(entry.value),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(entry.key == question.correctAnswerIndex ? '¡Correcto!' : 'Incorrecto'),
                          content: Text(entry.key == question.correctAnswerIndex
                              ? 'Has acertado la pregunta.'
                              : 'La respuesta correcta era: ${question.options[question.correctAnswerIndex]}'),
                          actions: [
                            TextButton(
                              child: Text('Volver a la ruleta'),
                              onPressed: () {
                                Navigator.of(context).popUntil((route) => route.isFirst);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}