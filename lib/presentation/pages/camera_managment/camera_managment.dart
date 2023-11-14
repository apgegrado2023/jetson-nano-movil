import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CameraManagmentPage extends StatefulWidget {
  const CameraManagmentPage({Key? key}) : super(key: key);

  @override
  State<CameraManagmentPage> createState() => _CameraManagmentPageState();
}

class _CameraManagmentPageState extends State<CameraManagmentPage> {
  static const String url = "ws://192.168.3.58:2007";
  //static const String url2 = "ws://192.168.3.58:8566";
  WebSocketChannel? _channel;
  //WebSocketChannel? _channel2;
  bool _isConnected = false;

  void connect() {
    _channel = IOWebSocketChannel.connect(Uri.parse(url));
    // _channel2 = IOWebSocketChannel.connect(Uri.parse(url2));
    setState(() {
      _isConnected = true;
    });
  }

  void disconnect() {
    _channel!.sink.close();
    //_channel2!.sink.close();
    setState(() {
      _isConnected = false;
    });
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    connect();
                  },
                  child: const Text("Connectar camaras"),
                ),
                ElevatedButton(
                  onPressed: disconnect,
                  child: const Text("Desconectar"),
                ),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
            _isConnected
                ? StreamBuilder(
                    stream: _channel!.stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        return const Center(
                          child: Text("Connection Closed !"),
                        );
                      }
                      //? Working for single frames
                      return Image.memory(
                        Uint8List.fromList(
                          base64Decode(
                            (snapshot.data.toString()),
                          ),
                        ),
                        gaplessPlayback: true,
                      );
                    },
                  )
                : const Text("Initiate Connection"),
            /*_isConnected
                ? StreamBuilder(
                    stream: _channel2!.stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        return const Center(
                          child: Text("Connection Closed !"),
                        );
                      }
                      //? Working for single frames
                      return Image.memory(
                        Uint8List.fromList(
                          base64Decode(
                            (snapshot.data.toString()),
                          ),
                        ),
                        gaplessPlayback: true,
                      );
                    },
                  )
                : const Text("Initiate Connection")*/
          ],
        ),
      ),
    );
  }
}
