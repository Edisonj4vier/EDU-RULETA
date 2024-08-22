import 'dart:math';

class Question {
  final String category;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.category,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

List<Question> questions = [
  Question(
    category: 'Matemáticas',
    questionText: '¿Cuál es el resultado de 8 x 7?',
    options: ['54', '56', '58', '60'],
    correctAnswerIndex: 1,
  ),
  Question(
    category: 'Historia',
    questionText: '¿En qué año se independizó Ecuador?',
    options: ['1820', '1822', '1830', '1835'],
    correctAnswerIndex: 2,
  ),
  Question(
    category: 'Ciencias Naturales',
    questionText: '¿Cuál es el órgano más grande del cuerpo humano?',
    options: ['Corazón', 'Cerebro', 'Pulmones', 'Piel'],
    correctAnswerIndex: 3,
  ),
  Question(
    category: 'Lenguaje',
    questionText: '¿Qué tipo de palabra es "rápidamente"?',
    options: ['Sustantivo', 'Adjetivo', 'Verbo', 'Adverbio'],
    correctAnswerIndex: 3,
  ),
  Question(
    category: 'Geografía',
    questionText: '¿Cuál es el río más largo de Ecuador?',
    options: ['Guayas', 'Napo', 'Pastaza', 'Esmeraldas'],
    correctAnswerIndex: 1,
  ),
  Question(
    category: 'Arte',
    questionText: '¿Quién pintó "La Mona Lisa"?',
    options: [
      'Vincent van Gogh',
      'Pablo Picasso',
      'Leonardo da Vinci',
      'Miguel Ángel'
    ],
    correctAnswerIndex: 2,
  ),
  // Añade más preguntas aquí...
];

Question getRandomQuestion() {
  final random = Random();
  return questions[random.nextInt(questions.length)];
}

Question getRandomQuestionByCategory(String category) {
  final categoryQuestions =
      questions.where((q) => q.category == category).toList();
  if (categoryQuestions.isEmpty) {
    // Si no hay preguntas en la categoría, devuelve una pregunta aleatoria
    return getRandomQuestion();
  }
  final random = Random();
  return categoryQuestions[random.nextInt(categoryQuestions.length)];
}
