import 'package:flutter/material.dart';
import '../view/viewTeacher/mis_cursos.dart'; // Asegúrate de importar la pantalla MisCursosPage

class PantallaDashboard extends StatelessWidget {
  final String rol;

  const PantallaDashboard({super.key, required this.rol});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard - $rol'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: _buildMenuItems(context),
        ),
      ),
      body: Center(
        child: Text('Bienvenido al Dashboard del $rol'),
      ),
    );
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    List<Widget> menuItems = [
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
          // Lógica para navegar a la pantalla de perfil
        },
      ),
      if (rol == 'Profesor') ...[
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text('Mis cursos'),
          onTap: () {
            // Navegar a la pantalla de Mis Cursos
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MisCursosPage()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.group),
          title: const Text('Mis estudiantes'),
          onTap: () {
            // Lógica para navegar a la pantalla de estudiantes
          },
        ),
      ],
      // Otras opciones para los diferentes roles...
      ListTile(
        leading: const Icon(Icons.exit_to_app, color: Colors.red),
        title: const Text('Salir', style: TextStyle(color: Colors.red)),
        onTap: () {
          Navigator.pop(context); // Cerrar el drawer
          Navigator.pushReplacementNamed(
              context, '/'); // Regresar a la pantalla principal
        },
      ),
    ];

    return menuItems;
  }
}
