import 'package:flutter/material.dart';

class MisCursosPage extends StatefulWidget {
  const MisCursosPage({super.key});

  @override
  _MisCursosPageState createState() => _MisCursosPageState();
}

class _MisCursosPageState extends State<MisCursosPage> {
  // Lista de cursos dinámica con dos cursos por defecto
  final List<Map<String, dynamic>> _cursos = [
    {'codigo': 'MAT101', 'asignatura': 'Matemáticas', 'preguntas': 20},
    {'codigo': 'HIS102', 'asignatura': 'Historia', 'preguntas': 25},
  ];

  // Función para agregar un nuevo curso
  void _agregarCurso(String codigo, String asignatura, int preguntas) {
    setState(() {
      _cursos.add({
        'codigo': codigo,
        'asignatura': asignatura,
        'preguntas': preguntas,
      });
    });
  }

  // Función para editar un curso
  void _editarCurso(
      int index, String codigo, String asignatura, int preguntas) {
    setState(() {
      _cursos[index] = {
        'codigo': codigo,
        'asignatura': asignatura,
        'preguntas': preguntas,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Eliminar la flecha de "Atrás"
        title: const Text('Mis Cursos'),
        backgroundColor: Colors.teal, // Cambiar el color del AppBar
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
                  builder: (context) =>
                      AgregarCursoDialog(onAgregarCurso: _agregarCurso),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Agregar Curso'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Color del botón agregar curso
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                color: Colors.lightBlueAccent, // Fondo celeste
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Número de columnas en la cuadrícula
                    childAspectRatio:
                        0.7, // Relación de aspecto para ajustar la altura
                  ),
                  itemCount: _cursos.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navegar al formulario de preguntas
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormularioPreguntasPage(
                              numPreguntas: _cursos[index]['preguntas'],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors
                            .amber[200], // Tarjetas de color amarillo claro
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Código: ${_cursos[index]['codigo']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  PopupMenuButton<String>(
                                    onSelected: (value) {
                                      if (value == 'Ver') {
                                        // Ver el curso
                                        showDialog(
                                          context: context,
                                          builder: (context) => VerCursoDialog(
                                              curso: _cursos[index]),
                                        );
                                      } else if (value == 'Editar') {
                                        // Editar el curso
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              EditarCursoDialog(
                                            curso: _cursos[index],
                                            onEditarCurso: (codigo, asignatura,
                                                preguntas) {
                                              _editarCurso(index, codigo,
                                                  asignatura, preguntas);
                                            },
                                          ),
                                        );
                                      } else if (value == 'Eliminar') {
                                        // Eliminar el curso
                                        setState(() {
                                          _cursos.removeAt(index);
                                        });
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
                              Text(
                                'Asignatura: ${_cursos[index]['asignatura']}',
                                style: const TextStyle(color: Colors.black87),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Preguntas: ${_cursos[index]['preguntas']}',
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AgregarCursoDialog extends StatefulWidget {
  final Function(String, String, int) onAgregarCurso;

  const AgregarCursoDialog({super.key, required this.onAgregarCurso});

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
              decoration:
                  const InputDecoration(labelText: 'Número de Preguntas'),
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
              // Llamar la función de callback para agregar el curso
              widget.onAgregarCurso(_codigoCurso, _asignatura, _numPreguntas);
              Navigator.of(context).pop(); // Cerrar el diálogo
            }
          },
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}

class EditarCursoDialog extends StatefulWidget {
  final Map<String, dynamic> curso;
  final Function(String, String, int) onEditarCurso;

  const EditarCursoDialog(
      {super.key, required this.curso, required this.onEditarCurso});

  @override
  _EditarCursoDialogState createState() => _EditarCursoDialogState();
}

class _EditarCursoDialogState extends State<EditarCursoDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _codigoCurso;
  late String _asignatura;
  late int _numPreguntas;

  @override
  void initState() {
    super.initState();
    _codigoCurso = widget.curso['codigo'];
    _asignatura = widget.curso['asignatura'];
    _numPreguntas = widget.curso['preguntas'];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Curso'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _codigoCurso,
              decoration: const InputDecoration(labelText: 'Código del Curso'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el código del curso';
                }
                return null;
              },
              onChanged: (value) {
                _codigoCurso = value;
              },
            ),
            TextFormField(
              initialValue: _asignatura,
              decoration: const InputDecoration(labelText: 'Asignatura'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la asignatura';
                }
                return null;
              },
              onChanged: (value) {
                _asignatura = value;
              },
            ),
            TextFormField(
              initialValue: _numPreguntas.toString(),
              decoration:
                  const InputDecoration(labelText: 'Número de Preguntas'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el número de preguntas';
                }
                return null;
              },
              onChanged: (value) {
                _numPreguntas = int.parse(value);
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
              widget.onEditarCurso(_codigoCurso, _asignatura, _numPreguntas);
              Navigator.of(context).pop(); // Cerrar el diálogo
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}

class VerCursoDialog extends StatelessWidget {
  final Map<String, dynamic> curso;

  const VerCursoDialog({super.key, required this.curso});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Detalles del Curso: ${curso['codigo']}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Asignatura: ${curso['asignatura']}'),
          Text('Número de Preguntas: ${curso['preguntas']}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cerrar el diálogo
          },
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}

class FormularioPreguntasPage extends StatefulWidget {
  final int numPreguntas; // Número de preguntas esperadas

  const FormularioPreguntasPage({super.key, required this.numPreguntas});

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
        automaticallyImplyLeading: false,
        title: const Text('Agregar Preguntas'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green,
              Colors.yellow,
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: _preguntas.length + 1,
          itemBuilder: (context, index) {
            if (index == _preguntas.length) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: _preguntas.length < widget.numPreguntas
                    ? ElevatedButton.icon(
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
                      )
                    : ElevatedButton(
                        onPressed: () {
                          // Aquí puedes manejar la lógica de finalizar la creación de preguntas
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Has completado todas las preguntas'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Botón verde "Listo"
                        ),
                        child: const Text('Listo'),
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
                        decoration:
                            const InputDecoration(labelText: 'Pregunta'),
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
                          DropdownMenuItem(
                              value: 0, child: Text('Respuesta 1')),
                          DropdownMenuItem(
                              value: 1, child: Text('Respuesta 2')),
                          DropdownMenuItem(
                              value: 2, child: Text('Respuesta 3')),
                          DropdownMenuItem(
                              value: 3, child: Text('Respuesta 4')),
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
      ),
    );
  }
}
