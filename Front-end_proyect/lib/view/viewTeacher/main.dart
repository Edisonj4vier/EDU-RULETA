import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class TeacherMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profesor - Dashboard'),
      ),
      drawer: CustomDrawer(userType: 'Profesor'),
      body: Center(
        child: Text('Bienvenido, Profesor'),
      ),
    );
  }
}
