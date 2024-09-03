import 'package:flutter/material.dart';
import '../viewStudent/game_screen.dart';

class CursosEstudiantes extends StatefulWidget {
  const CursosEstudiantes({Key? key}) : super(key: key);

  @override
  _CursosEstudiantesState createState() => _CursosEstudiantesState();
}

class _CursosEstudiantesState extends State<CursosEstudiantes> {
  final TextEditingController _codigoCursoController = TextEditingController();
  List<Map<String, String>> cursos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Cursos'),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Agregar Nuevo Curso',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _codigoCursoController,
                      decoration: InputDecoration(
                        labelText: 'Código del Curso',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.code),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_codigoCursoController.text.isNotEmpty) {
                          setState(() {
                            cursos.add({
                              'codigo': _codigoCursoController.text,
                              'nombre': 'Asignatura ${cursos.length + 1}'
                            });
                            _codigoCursoController.clear();
                          });
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Agregar Curso'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: cursos.isEmpty
                  ? Center(
                      child: Text(
                        'No tienes cursos agregados aún',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  : ListView.builder(
                      itemCount: cursos.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue[700],
                              child: Text(
                                cursos[index]['nombre']![0],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(cursos[index]['nombre']!),
                            subtitle:
                                Text('Código: ${cursos[index]['codigo']}'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GameScreen(),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
