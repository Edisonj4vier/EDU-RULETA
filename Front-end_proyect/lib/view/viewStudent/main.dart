import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class StudentMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estudiante - Dashboard'),
      ),
      drawer: CustomDrawer(userType: 'Estudiante'),
      body: Center(
        child: Text('Bienvenido, Estudiante'),
      ),
    );
  }
}
