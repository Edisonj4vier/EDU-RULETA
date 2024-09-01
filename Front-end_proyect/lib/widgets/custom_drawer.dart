import 'package:flutter/material.dart';
import '../view/viewStudent/cursos_estudiantes.dart';
class CustomDrawer extends StatelessWidget {
  final String userType;

  CustomDrawer({required this.userType});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildDrawerHeader(),
          ..._buildMenuItems(context), // Construye los elementos del menú basados en el tipo de usuario
          const Spacer(),
        ],
      ),
    );
  }

  /// Construye el encabezado del Drawer
  Widget _buildDrawerHeader() {
    return const DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Text(
        'Menú',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }

  /// Construye dinámicamente los elementos del menú basado en el tipo de usuario
  List<Widget> _buildMenuItems(BuildContext context) {
    List<Widget> menuItems = [
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Mi perfil'),
        onTap: () {
          // Acción para "Mi perfil"
          Navigator.pop(context); // Cerrar el drawer
        },
      ),
    ];

    // Elementos de menú específicos según el tipo de usuario
    if (userType == 'Estudiante') {
      menuItems.addAll([
        ListTile(
          leading: const Icon(Icons.question_answer),
          title: const Text('Mis ruletas'),
          onTap: () {
            // Acción para "Mis ruletas"

            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.grade),
          title: const Text('Mis notas'),
          onTap: () {

            // Acción para "Mis notas"
            Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => const CursosEstudiantes(),
                ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text('Material de apoyo'),
          onTap: () {
            // Acción para "Material de apoyo"
            Navigator.pop(context);
          },
        ),
      ]);
    } else if (userType == 'Profesor') {
      menuItems.addAll([
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text('Mis cursos'),
          onTap: () {
            // Acción para "Mis cursos"
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.group),
          title: const Text('Mis estudiantes'),
          onTap: () {
            // Acción para "Mis estudiantes"
            Navigator.pop(context);
          },
        ),
      ]);
    } else if (userType == 'Invitado') {
      menuItems.add(
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('Información del sistema'),
          onTap: () {
            // Acción para "Información del sistema"
            Navigator.pop(context);
          },
        ),
      );
    }

    menuItems.add(const Divider());

    // Opción de salir
    menuItems.add(
      ListTile(
        leading: const Icon(Icons.exit_to_app, color: Colors.red),
        title: const Text('Salir', style: TextStyle(color: Colors.red)),
        onTap: () {
          Navigator.pop(context); // Cerrar el drawer
          Navigator.pushReplacementNamed(context, '/'); // Regresar a la pantalla principal
        },
      ),
    );

    return menuItems;
  }
}
