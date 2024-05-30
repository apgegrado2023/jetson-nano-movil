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
      height: 131,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF6FC1C6), // C
        borderRadius:
            BorderRadius.all(Radius.circular(10.0)), // Radio de los bordes
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    10), // Ajusta este valor para cambiar el radio de los bordes
                color: Color.fromARGB(255, 82, 159, 163),
              ),
              child: Icon(
                Icons.system_security_update,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Uso CPU",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Center(
              child: Text(
                "${cpuUsage.toStringAsFixed(1)}%",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w200),
              ),
            ),
          ]),
    );
  }
}
