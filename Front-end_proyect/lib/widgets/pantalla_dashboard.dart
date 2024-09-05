import 'package:flutter/material.dart';
import '../view/viewStudent/cursos_estudiantes.dart';
import '../view/viewStudent/main.dart';
import '../view/viewTeacher/mis_cursos.dart';
// Importa aquí las vistas necesarias para el rol de admin

class PantallaDashboard extends StatefulWidget {
  final String rol;

  const PantallaDashboard({Key? key, required this.rol}) : super(key: key);

  @override
  _PantallaDashboardState createState() => _PantallaDashboardState();
}

class _PantallaDashboardState extends State<PantallaDashboard> {
  String currentView = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (currentView == 'home' && widget.rol == 'student')
          ? null
          : AppBar(
              title: Text('Dashboard - ${_getRolName(widget.rol)}'),
            ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: _buildMenuItems(context),
        ),
      ),
      body: _buildBody(),
    );
  }

  String _getRolName(String rol) {
    switch (rol) {
      case 'student':
        return 'Estudiante';
      case 'teacher':
        return 'Profesor';
      case 'admin':
        return 'Administrador';
      default:
        return 'Invitado';
    }
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    List<Widget> menuItems = [
      DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text(
          'Menú Principal',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      ListTile(
        leading: Icon(Icons.person),
        title: Text('Mi perfil'),
        onTap: () {
          setState(() {
            currentView = 'home';
          });
          Navigator.pop(context);
        },
      ),
    ];

    switch (widget.rol) {
      case 'student':
        menuItems.addAll([
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text('Mis ruletas'),
            onTap: () {
              setState(() {
                currentView = 'mis_ruletas';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.grade),
            title: Text('Mis notas'),
            onTap: () {
              setState(() {
                currentView = 'mis_notas';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Material de apoyo'),
            onTap: () {
              setState(() {
                currentView = 'material_apoyo';
              });
              Navigator.pop(context);
            },
          ),
        ]);
        break;
      case 'teacher':
        menuItems.addAll([
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Mis cursos'),
            onTap: () {
              setState(() {
                currentView = 'mis_cursos';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Mis estudiantes'),
            onTap: () {
              setState(() {
                currentView = 'mis_estudiantes';
              });
              Navigator.pop(context);
            },
          ),
        ]);
        break;
      case 'admin':
        menuItems.addAll([
          ListTile(
            leading: Icon(Icons.admin_panel_settings),
            title: Text('Panel de administración'),
            onTap: () {
              setState(() {
                currentView = 'admin_panel';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Gestión de usuarios'),
            onTap: () {
              setState(() {
                currentView = 'user_management';
              });
              Navigator.pop(context);
            },
          ),
        ]);
        break;
    }

    menuItems.addAll([
      Divider(),
      ListTile(
        leading: Icon(Icons.exit_to_app, color: Colors.red),
        title: Text('Salir', style: TextStyle(color: Colors.red)),
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
          return const StudentMainScreen();
        } else if (currentView == 'mis_ruletas') {
          return const CursosEstudiantes();
        }
        break;
      case 'teacher':
        if (currentView == 'mis_cursos') {
          return const MisCursosPage();
        }
        break;
      case 'admin':
        // Aquí deberías añadir las vistas específicas para el admin
        if (currentView == 'admin_panel') {
          // return AdminPanelScreen();
        } else if (currentView == 'user_management') {
          // return UserManagementScreen();
        }
        break;
    }

    // Vista por defecto si no se ha manejado específicamente
    return Center(
      child: Text('Bienvenido al Dashboard del ${_getRolName(widget.rol)}'),
    );
  }
}
