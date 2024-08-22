import 'package:flutter/material.dart';

class MisCursosPage extends StatelessWidget {
  const MisCursosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Cursos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // Abrir el formulario para agregar un nuevo curso
                showDialog(
                  context: context,
                  builder: (context) => const AgregarCursoDialog(),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Agregar Curso'),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      2, // Número de columnas en la cuadrícula (2 por fila)
                  childAspectRatio:
                      0.7, // Relación de aspecto para ajustar la altura
                ),
                itemCount: 3, // Mostrar solo 3 cursos
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navegar al formulario de preguntas
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FormularioPreguntasPage(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Código: CURSO123', // Código del curso (dinámico)
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                PopupMenuButton<String>(
                                  onSelected: (value) {
                                    // Lógica según la opción seleccionada
                                    if (value == 'Ver') {
                                      // Lógica para ver el curso
                                    } else if (value == 'Editar') {
                                      // Lógica para editar el curso
                                    } else if (value == 'Eliminar') {
                                      // Lógica para eliminar el curso
                                    }
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return {'Ver', 'Editar', 'Eliminar'}
                                        .map((String choice) {
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Text(
                                'Asignatura: Matemáticas'), // Asignatura (dinámico)
                            const SizedBox(height: 5),
                            const Text(
                                'Preguntas: 20'), // Número de preguntas (dinámico)
                          ],
                        ),
                      ),
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

class AgregarCursoDialog extends StatefulWidget {
  const AgregarCursoDialog({super.key});

  @override
  _AgregarCursoDialogState createState() => _AgregarCursoDialogState();
}

class _AgregarCursoDialogState extends State<AgregarCursoDialog> {
  final _formKey = GlobalKey<FormState>();
  String _codigoCurso = '';
  String _asignatura = '';
  int _numPreguntas = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Curso'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Código del Curso'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el código del curso';
                }
                return null;
              },
              onSaved: (value) {
                _codigoCurso = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Asignatura'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la asignatura';
                }
                return null;
              },
              onSaved: (value) {
                _asignatura = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Puntuacion'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el número de preguntas';
                }
                return null;
              },
              onSaved: (value) {
                _numPreguntas = int.parse(value!);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cerrar el diálogo sin guardar
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // Lógica para guardar el nuevo curso
              Navigator.of(context).pop(); // Cerrar el diálogo
            }
          },
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}

class FormularioPreguntasPage extends StatefulWidget {
  const FormularioPreguntasPage({super.key});

  @override
  _FormularioPreguntasPageState createState() =>
      _FormularioPreguntasPageState();
}

class _FormularioPreguntasPageState extends State<FormularioPreguntasPage> {
  final List<Map<String, dynamic>> _preguntas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Preguntas'),
      ),
      body: ListView.builder(
        itemCount: _preguntas.length + 1,
        itemBuilder: (context, index) {
          if (index == _preguntas.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _preguntas.add({
                      'pregunta': '',
                      'respuestas': ['', '', '', ''],
                      'correcta': 0,
                      'link': '',
                    });
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Agregar Pregunta'),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Pregunta'),
                      onChanged: (value) {
                        _preguntas[index]['pregunta'] = value;
                      },
                    ),
                    for (int i = 0; i < 4; i++)
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Respuesta ${i + 1}'),
                        onChanged: (value) {
                          _preguntas[index]['respuestas'][i] = value;
                        },
                      ),
                    DropdownButton<int>(
                      value: _preguntas[index]['correcta'],
                      onChanged: (value) {
                        setState(() {
                          _preguntas[index]['correcta'] = value!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(value: 0, child: Text('Respuesta 1')),
                        DropdownMenuItem(value: 1, child: Text('Respuesta 2')),
                        DropdownMenuItem(value: 2, child: Text('Respuesta 3')),
                        DropdownMenuItem(value: 3, child: Text('Respuesta 4')),
                      ],
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Link sobre el tema'),
                      onChanged: (value) {
                        _preguntas[index]['link'] = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
