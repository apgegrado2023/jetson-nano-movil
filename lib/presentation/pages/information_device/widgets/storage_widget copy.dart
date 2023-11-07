import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';

class StorageWidget extends StatelessWidget {
  final double temp;
  const StorageWidget({super.key, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 51, 51, 51), //
        borderRadius:
            BorderRadius.all(Radius.circular(10.0)), // Radio de los bordes
      ),
      child: Column(children: [
        Text(
          "Temperatura",
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "$temp c°",
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.w200),
        ),
      ]),
    );
  }
}
