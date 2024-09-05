import 'package:edu_ruleta/view/viewTeacher/main.dart'; // Importa la pantalla principal del profesor
import 'package:flutter/material.dart';
import '../view/viewStudent/cursos_estudiantes.dart';
import '../view/viewStudent/main.dart';
import '../view/viewTeacher/mis_cursos.dart'; // Importa la página de gestión de cursos del profesor

class PantallaDashboard extends StatefulWidget {
  final String rol;

  const PantallaDashboard({Key? key, required this.rol}) : super(key: key);

  @override
  _PantallaDashboardState createState() => _PantallaDashboardState();
}

class _PantallaDashboardState extends State<PantallaDashboard> {
  String currentView = 'home'; // Inicializamos la vista por defecto

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (currentView == 'home')
          ? null // Elimina el AppBar si estás en la vista principal
          : AppBar(
              title: Text('Dashboard - ${_getRolName(widget.rol)}'),
            ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: _buildMenuItems(context),
        ),
      ),
      body: _buildBody(), // Se muestra el contenido correspondiente
    );
  }

  String _getRolName(String rol) {
    switch (rol) {
      case 'student':
        return 'Estudiante';
      case 'teacher':
        return 'Profesor';
      default:
        return 'Estudiante'; // Por defecto, estudiante
    }
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
            currentView = 'home'; // Cambia a la vista de inicio
          });
          Navigator.pop(context);
        },
      ),
    ];

    // Dependiendo del rol del usuario, agregamos elementos al menú
    switch (widget.rol) {
      case 'student':
        menuItems.addAll([
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Text('Mis ruletas'),
            onTap: () {
              setState(() {
                currentView = 'mis_ruletas'; // Cambia a la vista de ruletas
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.grade),
            title: const Text('Mis notas'),
            onTap: () {
              setState(() {
                currentView = 'mis_notas'; // Cambia a la vista de notas
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Material de apoyo'),
            onTap: () {
              setState(() {
                currentView = 'material_apoyo'; // Cambia a la vista de material
              });
              Navigator.pop(context);
            },
          ),
        ]);
        break;
      case 'teacher':
        menuItems.addAll([
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Mis cursos'),
            onTap: () {
              setState(() {
                currentView = 'mis_cursos'; // Cambia a la vista de cursos
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Mis estudiantes'),
            onTap: () {
              setState(() {
                currentView =
                    'mis_estudiantes'; // Cambia a la vista de estudiantes
              });
              Navigator.pop(context);
            },
          ),
        ]);
        break;
    }

    menuItems.addAll([
      const Divider(),
      ListTile(
        leading: const Icon(Icons.exit_to_app, color: Colors.red),
        title: const Text('Salir', style: TextStyle(color: Colors.red)),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/');
        },
      ),
    ]);

    return menuItems;
  }

  Widget _buildBody() {
    switch (widget.rol) {
      case 'student':
        if (currentView == 'home') {
          return const StudentMainScreen(); // Muestra la pantalla principal del estudiante
        } else if (currentView == 'mis_ruletas') {
          return const CursosEstudiantes(); // Muestra los cursos del estudiante
        }
        break;
      case 'teacher':
        if (currentView == 'home') {
          return const TeacherMainScreen(); // Muestra la pantalla principal del profesor sin el AppBar
        } else if (currentView == 'mis_cursos') {
          return const MisCursosPage(); // Muestra los cursos del profesor
        }
        break;
    }

    // Vista por defecto si no se ha manejado específicamente
    return Center(
      child: Text('Bienvenido al Dashboard del ${_getRolName(widget.rol)}'),
    );
  }
}
