import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TempWidget extends StatelessWidget {
  final double temp;
  const TempWidget({super.key, required this.temp});

  @override
  Widget build(BuildContext context) {
    _calculationPercentage() {
      double valorMaximo = 80;

      double porcentaje = (temp / valorMaximo) * 100;
      return porcentaje;
    }

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.all(Radius.circular(10.0)), // Radio de los bordes
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Almacenamiento",
            style: TextStyle(
                fontSize: 17,
                color: Color.fromARGB(255, 74, 64, 161),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 226, 226, 226),
              borderRadius: BorderRadius.all(
                  Radius.circular(10.0)), // Radio de los bordes
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: FractionallySizedBox(
                    widthFactor: _calculationPercentage() / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 61, 55, 136),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0)), // Radio de
                        /*radient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                           
                            Color.fromARGB(255, 209, 53, 53)
                          ],
                        ),*/
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            temp.toString() + " c°",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Row(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Color.fromARGB(255, 209, 209, 209),
                      child: SizedBox(
                        height: 7,
                        width: 25,
                        child: Text(""),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Baja",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Color.fromARGB(255, 252, 122, 16),
                      child: SizedBox(
                        height: 7,
                        width: 25,
                        child: Text(""),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Media",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Color.fromARGB(255, 211, 61, 24),
                      child: SizedBox(
                        height: 7,
                        width: 25,
                        child: Text(""),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Alta",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
