import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:udp/udp.dart';

class GestionPage extends StatefulWidget {
  @override
  _GestionPageState createState() => _GestionPageState();
}

class _GestionPageState extends State<GestionPage> {
  Socket? clientSocket;
  List<int> imageBytes = [];
  bool isActivate = false;
  Image? videoFrame;
  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() async {
    try {
      clientSocket = await Socket.connect(SERVER_IP, SERVER_PORT);
      setState(() {
        isActivate = true;
      });
      clientSocket!.listen(
        (Uint8List data) {
          final buffer = data.buffer.asUint8List();
          print(buffer);
          setState(() {
            videoFrame = Image.memory(buffer);
          });
        },
        onDone: () {
          print('Conexión cerrada por el servidor');
          clientSocket?.destroy();
        },
        onError: (e) {
          print('Error de conexión: $e');
        },
      );
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cliente Flutter'),
      ),
      body: Center(
        child: videoFrame ?? CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    clientSocket?.destroy();
    super.dispose();
  }
}

const SERVER_IP = '192.168.3.58'; // Reemplaza con la dirección IP del servidor
const SERVER_PORT = 12345; // Reemplaza con el puerto del servidor