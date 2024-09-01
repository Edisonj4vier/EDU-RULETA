import 'package:flutter/material.dart';
import '../view/viewStudent/cursos_estudiantes.dart'; // Importa el archivo para estudiantes
import '../view/viewStudent/main.dart';
import '../view/viewTeacher/mis_cursos.dart'; // Importa el archivo para profesores

class PantallaDashboard extends StatefulWidget {
  final String rol;

  const PantallaDashboard({super.key, required this.rol});

  @override
  _PantallaDashboardState createState() => _PantallaDashboardState();
}

class _PantallaDashboardState extends State<PantallaDashboard> {
  String currentView = 'home'; // Para manejar qué contenido mostrar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (currentView == 'home' && widget.rol == 'Estudiante')
          ? null // No mostrar AppBar cuando la vista es para estudiantes
          : AppBar(
        title: Text('Dashboard - ${widget.rol}'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: _buildMenuItems(context),
        ),
      ),
      body: _buildBody(), // Este método construirá el contenido dinámico
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
          setState(() {
            currentView = 'home';
          });
          Navigator.pop(context);
        },
      ),
      if (widget.rol == 'Estudiante') ...[
        ListTile(
          leading: const Icon(Icons.question_answer),
          title: const Text('Mis ruletas'),
          onTap: () {
            setState(() {
              currentView = 'mis_ruletas'; // Cambia el contenido a "Mis ruletas"
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.grade),
          title: const Text('Mis notas'),
          onTap: () {
            setState(() {
              currentView = 'mis_notas';
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text('Material de apoyo'),
          onTap: () {
            setState(() {
              currentView = 'material_apoyo';
            });
            Navigator.pop(context);
          },
        ),
      ] else if (widget.rol == 'Profesor') ...[
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text('Mis cursos'),
          onTap: () {
            setState(() {
              currentView = 'mis_cursos';
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.group),
          title: const Text('Mis estudiantes'),
          onTap: () {
            setState(() {
              currentView = 'mis_estudiantes';
            });
            Navigator.pop(context);
          },
        ),
      ] else if (widget.rol == 'Invitado') ...[
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('Información del sistema'),
          onTap: () {
            setState(() {
              currentView = 'info_sistema';
            });
            Navigator.pop(context);
          },
        ),
      ],
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
    ];

    return menuItems;
  }

  Widget _buildBody() {
    // Mostrar StudentMainScreen si el rol es 'Estudiante' y la vista es 'home'
    if (widget.rol == 'Estudiante' && currentView == 'home') {
      return const StudentMainScreen(); // Mostrar la pantalla específica para estudiantes
    } else if (currentView == 'mis_ruletas') {
      return const CursosEstudiantes(); // Mostrar la pantalla para estudiantes
    } else if (currentView == 'mis_cursos') {
      return const MisCursosPage(); // Mostrar la pantalla para profesores
    }
    // Agrega más pantallas aquí según currentView

    // Pantalla principal por defecto
    return Center(
      child: Text('Bienvenido al Dashboard del ${widget.rol}'),
    );
  }
}
