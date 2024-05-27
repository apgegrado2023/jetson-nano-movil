import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';

class TemperatureWidget extends StatelessWidget {
  final double temp;
  const TemperatureWidget({super.key, required this.temp});

  @override
  Widget build(BuildContext context) {
    String estado;
    Color color;

    // Definir el rango de temperaturas para los diferentes estados.
    if (temp > 50) {
      estado = "Alto";
      color = Colors.red;
    } else if (temp >= 35 && temp <= 49) {
      estado = "Medio";
      color = Colors.orange;
    } else {
      estado = "Estable";
      color = Color.fromARGB(255, 138, 221, 181);
    }

    return Container(
      height: 210,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(51, 51, 51, 1), //
        borderRadius:
            BorderRadius.all(Radius.circular(10.0)), // Radio de los bordes
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      10), // Ajusta este valor para cambiar el radio de los bordes
                  color: Color.fromARGB(255, 43, 42, 42)),
              child: Icon(
                Icons.heat_pump,
                color: Colors.white,
              ),
            ), //
            SizedBox(
              height: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Temperatura",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "$temp c°",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w200),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                10), // Ajusta este valor para cambiar el radio de los bordes
                            color: Color.fromARGB(255, 43, 42, 42)),
                        child: Text(
                          estado,
                          style: TextStyle(color: color),
                        ),
                      ),
                    ), //
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Temperatura del dispositivo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
