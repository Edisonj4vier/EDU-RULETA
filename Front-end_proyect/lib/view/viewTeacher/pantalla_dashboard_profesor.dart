import 'package:flutter/material.dart';

class PantallaDashboardProfesor extends StatelessWidget {
  const PantallaDashboardProfesor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard - Profesor'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú Principal',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Mi perfil'),
              onTap: () {
                // Navegar a la pantalla de perfil
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Mis cursos'),
              onTap: () {
                // Navegar a la pantalla de cursos
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Mis estudiantes'),
              onTap: () {
                // Navegar a la pantalla de estudiantes
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text('Salir', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context); // Cerrar el drawer
                Navigator.pushReplacementNamed(
                    context, '/'); // Regresar a la pantalla principal
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Bienvenido al Dashboard del Profesor'),
      ),
    );
  }
}
