import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CpuWidget extends StatelessWidget {
  final double cpuUsage;
  const CpuWidget({super.key, required this.cpuUsage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 51, 51, 51), // C
        borderRadius:
            BorderRadius.all(Radius.circular(10.0)), // Radio de los bordes
      ),
      child: Column(children: [
        Text(
          "Uso CPU",
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "$cpuUsage%",
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.w200),
        ),
      ]),
    );
  }
}
