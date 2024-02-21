import 'package:flutter/material.dart';

class ConnectionWidget extends StatelessWidget {
  final bool isConnection;
  const ConnectionWidget({
    super.key,
    required this.isConnection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: [
      Icon(
        Icons.circle,
        color: Colors.redAccent,
      ),
      SizedBox(
        width: 8,
      ),
      Text(
        isConnection ? "Conectado" : "No estas conectado",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      )
    ]));
  }
}
