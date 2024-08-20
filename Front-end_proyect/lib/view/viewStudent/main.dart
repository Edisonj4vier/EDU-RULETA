import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';
import 'game_screen.dart';

class StudentMainScreen extends StatelessWidget {
  const StudentMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estudiante - Dashboard'),
      ),
      drawer: CustomDrawer(userType: 'Estudiante'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bienvenido, Estudiante'),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Jugar Edu-Ruleta'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}