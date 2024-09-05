import 'package:flutter/material.dart';
import '../view/viewStudent/mis_notas.dart';
import '../view/viewStudent/material_apoyo.dart';
import '../view/viewStudent/cursos_estudiantes.dart';

class CustomDrawer extends StatelessWidget {
  final String userType;

  const CustomDrawer({Key? key, required this.userType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.yellowAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.sentiment_satisfied_alt,
                  size: 50,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.blueAccent),
            title: Text(
              'Mi perfil',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
              // Aquí puedes redirigir a la pantalla de perfil
            },
          ),
          ListTile(
            leading: Icon(Icons.book, color: Colors.purpleAccent),
            title: Text(
              'Mis ruletas',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CursosEstudiantes()), // Cambia según tu pantalla
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.grade, color: Colors.greenAccent),
            title: Text(
              'Mis notas',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MisNotasScreen()), // Redirige a mis notas
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.video_library, color: Colors.orangeAccent),
            title: Text(
              'Material de apoyo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MaterialApoyoScreen()), // Redirige a material de apoyo
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: Text('Salir',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
