import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa el paquete url_launcher
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
  int selectedIndex = -1; // Inicializa el índice seleccionado en -1

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  void _spinWheel() {
    setState(() {
      selectedIndex = Fortune.randomInt(0, items.length); // Gira la ruleta
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
                if (selectedIndex != -1) {
                  // Asegúrate de que la ruleta ha girado
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionPage(
                        question:
                            getRandomQuestionByCategory(items[selectedIndex]),
                        onReturnToWheel: () {
                          // Retorna a la pantalla de la ruleta
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GameScreen()),
                          );
                        },
                      ),
                    ),
                  );
                }
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
  final VoidCallback onReturnToWheel;

  QuestionPage({required this.question, required this.onReturnToWheel});

  // Función para abrir un enlace en el navegador
  void _launchURL() async {
    const url =
        'https://www.youtube.com/watch?v=0d5VWxcSUIk'; // Enlace de ejemplo
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                        bool isCorrect =
                            entry.key == question.correctAnswerIndex;
                        return AlertDialog(
                          title: Text(isCorrect ? '¡Correcto!' : 'Incorrecto'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(isCorrect
                                  ? '¡Muy bien! Sigue estudiando y serás el mejor.'
                                  : '¡Oooo nooo! La respuesta ha sido equivocada, pero no te preocupes, la próxima vez lo lograremos.'),
                              if (!isCorrect)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: GestureDetector(
                                    onTap:
                                        _launchURL, // Abre el enlace al hacer clic
                                    child: Text(
                                      'Revisar el contenido',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: Text('Volver a la ruleta'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Cierra el diálogo
                                onReturnToWheel(); // Vuelve a la ruleta
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
