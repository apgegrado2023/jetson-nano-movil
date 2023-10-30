import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';

class TempWidget extends StatelessWidget {
  final StorageInfo temp;
  const TempWidget({super.key, required this.temp});

  @override
  Widget build(BuildContext context) {
    _calculationPercentage() {
      double valorMaximo = temp.total * 1.0;

      double porcentaje = (temp.used / valorMaximo) * 100;
      return porcentaje;
    }

    int obtenerDigitoMasGrande(int numero) {
      int digitoMasGrande = 0;

      while (numero > 0) {
        int digito = numero % 10;
        if (digito > digitoMasGrande) {
          digitoMasGrande = digito;
        }
        numero ~/= 10;
      }

      return digitoMasGrande;
    }

    double bytesToGigabytes(int bytes) {
      return bytes / (1024 * 1024 * 1024);
    }

    print(obtenerDigitoMasGrande(_calculationPercentage().toInt()));
    print(10 - obtenerDigitoMasGrande(_calculationPercentage().toInt()));
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.all(Radius.circular(10.0)), // Radio de los bordes
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
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
          Row(
            children: <Widget>[
              Expanded(
                flex: obtenerDigitoMasGrande(_calculationPercentage().toInt()),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 77, 173),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ), // Radio de los bordes
                  ),
                  height: 50,
                  child: Center(
                    child: Text(
                      ' ${_calculationPercentage().toStringAsFixed(2)}%',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 10 -
                    obtenerDigitoMasGrande(_calculationPercentage().toInt()),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 80, 211, 123),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ), // Radio de los bordes
                  ),
                  height: 50,
                  child: Center(
                    child: Text(
                      ' ${(100 - _calculationPercentage()).toStringAsFixed(2)}%',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${bytesToGigabytes(temp.free).toStringAsFixed(0)} GB disponibles de ${bytesToGigabytes(temp.total).toStringAsFixed(0)} GB ",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
