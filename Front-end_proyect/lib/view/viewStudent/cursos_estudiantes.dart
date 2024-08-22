import 'package:flutter/material.dart';
import '../viewStudent/game_screen.dart'; // Asegúrate de importar la pantalla de la ruleta

class CursosEstudiantes extends StatefulWidget {
  const CursosEstudiantes({super.key});

  @override
  _CursosEstudiantesState createState() => _CursosEstudiantesState();
}

class _CursosEstudiantesState extends State<CursosEstudiantes> {
  final TextEditingController _codigoCursoController = TextEditingController();
  List<Map<String, String>> cursos = []; // Lista de cursos agregados

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _codigoCursoController,
                  decoration: const InputDecoration(
                    labelText: 'Código del Curso',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    cursos.add({
                      'codigo': _codigoCursoController.text,
                      'nombre':
                          'Asignatura X' // Puedes cambiar esto según la lógica que necesites
                    });
                    _codigoCursoController.clear();
                  });
                },
                child: const Text('Agregar Curso'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: cursos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navegar a la pantalla de la ruleta
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameScreen(),
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text('Curso: ${cursos[index]['nombre']}'),
                      subtitle: Text('Código: ${cursos[index]['codigo']}'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
