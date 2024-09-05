import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa el paquete

class MaterialApoyoScreen extends StatelessWidget {
  const MaterialApoyoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> materiales = [
      {
        'materia': 'Lenguaje',
        'link':
            'https://www.youtube.com/watch?v=CqTXFbnG0ag&ab_channel=MundoCanticuentos'
      },
      {
        'materia': 'Matemáticas',
        'link':
            'https://www.youtube.com/watch?v=0d5VWxcSUIk&t=4s&ab_channel=Matem%C3%A1ticasconGrajeda'
      },
      {
        'materia': 'Historia',
        'link':
            'https://www.youtube.com/watch?v=MkadaSZJ8uw&ab_channel=ElMapadeSebas'
      },
      {
        'materia': 'Ciencias',
        'link':
            'https://www.youtube.com/watch?v=WtOMDHBZ_-w&ab_channel=LifederEducaci%C3%B3n'
      },
      {
        'materia': 'Inglés',
        'link':
            'https://www.youtube.com/watch?v=TZ6eC2EMstQ&list=PLJ4xOdhWU2rS-daJ_1uDmpOPLFR-7b3Px&ab_channel=AmigoMumuEspa%C3%B1ol'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Material de Apoyo'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.pinkAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: materiales.length,
          itemBuilder: (context, index) {
            final material = materiales[index];
            return Card(
              color: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_circle_filled,
                        size: 40, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(
                      'Materia: ${material['materia']}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () async {
                        final url = material['link'];
                        if (await canLaunch(url!)) {
                          await launch(url); // Abre el enlace en YouTube
                        } else {
                          throw 'No se pudo abrir $url';
                        }
                      },
                      icon: Icon(Icons.link),
                      label: Text('Ver Video'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
