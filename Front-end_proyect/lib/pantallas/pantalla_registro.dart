import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key});

  @override
  _PantallaRegistroState createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final _formKey = GlobalKey<FormState>();
  bool _terminosAceptados = false;
  bool _mostrarMensajeErrorCampos = false;
  bool _mostrarMensajeErrorTerminos = false;
  String? _password;
  String? _confirmPassword;
  String? _nombre;
  String? _apellido;
  String? _email;

  Future<void> _registrarse() async {
    final url = Uri.parse('https://edu-ruleta.onrender.com/api/auth/register');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _email!,
        'password': _password!,
        'fullName': '$_nombre $_apellido',
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario ha sido registrado con éxito')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Error ${response.statusCode}: ${response.reasonPhrase}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: Colors.lightBlue[300], // Azul claro
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlueAccent,
              Colors.green,
            ],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                onChanged: (value) {
                  _nombre = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Apellido'),
                onChanged: (value) {
                  _apellido = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su apellido';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  _email = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                onChanged: (value) {
                  _password = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Verificar Contraseña'),
                obscureText: true,
                onChanged: (value) {
                  _confirmPassword = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor verifique su contraseña';
                  }
                  if (value != _password) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text('Acepto términos y condiciones'),
                value: _terminosAceptados,
                onChanged: (bool? value) {
                  setState(() {
                    _terminosAceptados = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 20),
              if (_mostrarMensajeErrorCampos)
                const Text(
                  'Por favor complete todos los campos.',
                  style: TextStyle(color: Colors.red),
                ),
              if (_mostrarMensajeErrorTerminos)
                const Text(
                  'Debe aceptar los términos y condiciones.',
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _mostrarMensajeErrorCampos = false;
                    _mostrarMensajeErrorTerminos = false;

                    if (!_formKey.currentState!.validate()) {
                      _mostrarMensajeErrorCampos = true;
                    }

                    if (!_terminosAceptados) {
                      _mostrarMensajeErrorTerminos = true;
                    }

                    if (!_mostrarMensajeErrorCampos &&
                        !_mostrarMensajeErrorTerminos) {
                      _registrarse();
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[800], // Rojo oscuro
                ),
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
