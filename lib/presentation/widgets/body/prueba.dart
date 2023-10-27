import 'package:flutter/material.dart';

class Prueba extends StatelessWidget {
  const Prueba({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        child: Text("Hola mundo"),
      ),
    ]));
  }
}
// Card widget tutorial

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Card Widget Tutorial'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              'https://picsum.photos/400/300',
              width: 200,
              height: 150,
            ),
            const Text(
              "Welcome to AllAboutFlutter",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
            ListView.builder(
              itemCount: 20, // Número de elementos en la lista
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Elemento $index'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
