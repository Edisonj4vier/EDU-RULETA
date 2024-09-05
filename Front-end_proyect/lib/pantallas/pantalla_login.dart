import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/pantalla_dashboard.dart';

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

  Future<void> _loginWithRetry(String email, String password,
      {int retries = 3}) async {
    for (int i = 0; i < retries; i++) {
      try {
        await _login(email, password);
        return; // Si el login es exitoso, salimos de la función
      } catch (e) {
        if (i == retries - 1) {
          // Si es el último intento, mostramos el error
          setState(() {
            _errorMessage = 'Error del servidor. Por favor, intenta más tarde.';
          });
        } else {
          // Esperamos un poco antes de reintentar
          await Future.delayed(Duration(seconds: 2));
        }
      }
    }
  }

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
          String token = responseBody['token'];

          // Usar el token para obtener el rol del usuario desde el endpoint `/api/auth/check-status`
          await _getUserRole(token);
        } else {
          setState(() {
            _errorMessage = 'Respuesta inesperada del servidor';
          });
        }
      } else if (response.statusCode == 400) {
        setState(() {
          _errorMessage = 'Credenciales inválidas';
        });
      } else if (response.statusCode == 502) {
        setState(() {
          _errorMessage =
              'Error del servidor (502). Por favor, intenta más tarde.';
        });
      } else {
        setState(() {
          _errorMessage = 'Error de autenticación: ${response.statusCode}';
        });
      }
    } catch (e) {
      print('Error detallado: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error en la conexión: $e';
      });
    }
  }

  Future<void> _getUserRole(String token) async {
    final url =
        Uri.parse('https://edu-ruleta.onrender.com/api/auth/check-status');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print('Response body after check-status: $responseBody');

        // Obtener el rol del usuario desde la respuesta
        List<String> roles = List<String>.from(responseBody['roles'] ?? []);

        // Verifica que el rol no esté vacío y se asigna correctamente
        String rol = 'student'; // Valor por defecto

        if (roles.isNotEmpty) {
          if (roles.contains('admin')) {
            rol = 'admin';
          } else if (roles.contains('teacher')) {
            rol = 'teacher';
          } else if (roles.contains('student')) {
            rol = 'student';
          }
        } else {
          print("No roles found for the user. Defaulting to student.");
        }

        // Redirigir al dashboard correcto
        _redirectUser(rol);
      } else {
        setState(() {
          _errorMessage = 'No se pudo obtener el rol del usuario';
        });
      }
    } catch (e) {
      print('Error obteniendo el rol: $e');
      setState(() {
        _errorMessage = 'Error al obtener el rol: $e';
      });
    }
  }

  void _redirectUser(String rol) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Bienvenido, rol: $rol', style: TextStyle(color: Colors.blue)),
        duration: Duration(seconds: 2),
      ),
    );

    // Ahora ambos roles son redirigidos a la misma pantalla (pantalla_dashboard), enviando el rol
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PantallaDashboard(rol: rol), // Enviamos el rol a la pantalla
      ),
    );
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
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      _loginWithRetry(email, password);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 13, 179, 62),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Iniciar sesión', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
