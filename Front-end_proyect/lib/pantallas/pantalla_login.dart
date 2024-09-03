import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/pantalla_dashboard.dart'; // Asegúrate de que esta ruta sea correcta

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({Key? key}) : super(key: key);

  @override
  _PantallaLoginState createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  bool _isLoading = false;

  Future<void> _login(String email, String password) async {
    final url = Uri.parse('https://edu-ruleta.onrender.com/api/auth/login');

    setState(() {
      _errorMessage = '';
      _isLoading = true;
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print('Response body: $responseBody');

        if (responseBody.containsKey('token')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Bienvenido', style: TextStyle(color: Colors.blue)),
              duration: Duration(seconds: 2),
            ),
          );
          await Future.delayed(Duration(seconds: 2));

          // Determina el rol del usuario (ajusta esto según la respuesta de tu backend)
          String rol = responseBody['rol'] ?? 'Estudiante';

          // Navega a PantallaDashboard
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PantallaDashboard(rol: rol),
            ),
          );
        } else {
          setState(() {
            _errorMessage = 'Respuesta inesperada del servidor';
          });
        }
      } else if (response.statusCode == 400) {
        setState(() {
          _errorMessage = 'Ese usuario no existe';
        });
      } else {
        setState(() {
          _errorMessage = 'Error de autenticación: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error en la conexión: $e';
      });
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Color.fromARGB(182, 13, 179, 62).withOpacity(0.7),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Colors.lightBlueAccent],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Color.fromARGB(255, 138, 3, 32)),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      _login(email, password);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(109, 255, 1, 1).withOpacity(0.7),
              ),
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
