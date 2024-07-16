import 'package:flutter/material.dart';
import 'viewStudent/main.dart';
import 'viewTeacher/main.dart';

class RegisterUserScreen extends StatefulWidget {
  @override
  _RegisterUserScreenState createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _apellido = '';
  DateTime? _fechaNacimiento;
  String _tipoUsuario = 'Ninguno';
  String _descripcion = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Jugador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                onSaved: (value) {
                  _nombre = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Apellido'),
                onSaved: (value) {
                  _apellido = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Fecha de Nacimiento'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      _fechaNacimiento = date;
                    });
                  }
                },
                validator: (value) {
                  if (_fechaNacimiento == null) {
                    return 'Por favor seleccione una fecha';
                  }
                  return null;
                },
                readOnly: true,
                controller: TextEditingController(
                  text: _fechaNacimiento == null
                      ? ''
                      : '${_fechaNacimiento!.toLocal()}'.split(' ')[0],
                ),
              ),
              DropdownButtonFormField<String>(
                value: _tipoUsuario,
                items:
                    ['Ninguno', 'Estudiante', 'Profesor'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _tipoUsuario = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: '¿Qué eres?'),
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Descripción de Jugador'),
                maxLines: 3,
                onSaved: (value) {
                  _descripcion = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Navegar a la pantalla correcta según el tipo de usuario
                    if (_tipoUsuario == 'Estudiante') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentMainScreen()),
                      );
                    } else if (_tipoUsuario == 'Profesor') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeacherMainScreen()),
                      );
                    }
                  }
                },
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
