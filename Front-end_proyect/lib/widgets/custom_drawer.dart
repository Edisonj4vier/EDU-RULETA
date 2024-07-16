import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String userType;

  CustomDrawer({required this.userType});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
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
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              // Acción para el dashboard
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Cursos'),
            onTap: () {
              // Acción para cursos
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuraciones'),
            onTap: () {
              // Acción para configuraciones
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Ayuda'),
            onTap: () {
              // Acción para ayuda
            },
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil - $userType'),
            onTap: () {
              // Acción para perfil
            },
          ),
        ],
      ),
    );
  }
}
