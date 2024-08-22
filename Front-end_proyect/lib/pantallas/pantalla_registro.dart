import 'package:flutter/material.dart';
import '../widgets/pantalla_dashboard.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key});

  @override
  _PantallaRegistroState createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final _formKey = GlobalKey<FormState>();
  String? _rolSeleccionado = 'Invitado'; // Valor por defecto
  bool _terminosAceptados = false;
  bool _mostrarMensajeErrorCampos = false;
  bool _mostrarMensajeErrorTerminos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Apellido'),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Apodo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su apodo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _rolSeleccionado,
                decoration: const InputDecoration(labelText: 'Rol'),
                items: const [
                  DropdownMenuItem(
                      value: 'Estudiante', child: Text('Estudiante')),
                  DropdownMenuItem(value: 'Profesor', child: Text('Profesor')),
                  DropdownMenuItem(value: 'Invitado', child: Text('Invitado')),
                ],
                onChanged: (value) {
                  setState(() {
                    _rolSeleccionado = value;
                  });
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Registro exitoso')),
                      );

                      // Navegar al dashboard correspondiente según el rol
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PantallaDashboard(rol: _rolSeleccionado!),
                        ),
                      );
                    }
                  });
                },
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
