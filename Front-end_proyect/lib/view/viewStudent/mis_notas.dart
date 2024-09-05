import 'package:flutter/material.dart';

class MisNotasScreen extends StatelessWidget {
  const MisNotasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notas = [
      {'codigo': 'RU001', 'materia': 'Lenguaje', 'nota': '85'},
      {'codigo': 'RU002', 'materia': 'Matemáticas', 'nota': '92'},
      {'codigo': 'RU003', 'materia': 'Historia', 'nota': '78'},
      {'codigo': 'RU004', 'materia': 'Ciencias', 'nota': '88'},
      {'codigo': 'RU005', 'materia': 'Inglés', 'nota': '90'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Notas'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.orangeAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: notas.length,
          itemBuilder: (context, index) {
            final nota = notas[index];
            return Card(
              color: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.school, size: 40, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(
                      'Código: ${nota['codigo']}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Materia: ${nota['materia']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Nota: ${nota['nota']}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
