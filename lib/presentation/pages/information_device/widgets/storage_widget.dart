import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';
import 'package:flutter_application_prgrado/domain/entities/information_system.dart';

class StorageWidget extends StatelessWidget {
  final StorageInfoEntity temp;
  const StorageWidget({super.key, required this.temp});

  @override
  Widget build(BuildContext context) {
    _calculationPercentage() {
      double valorMaximo = temp.total! * 1.0;

      double porcentaje = (temp.used! / valorMaximo) * 100;
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
      height: 200,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF7880CD),
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
              color: Color.fromARGB(255, 104, 115, 209),
            ),
            child: Icon(
              Icons.storage_outlined,
              color: Colors.white,
            ),
          ), //
          SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Almacenamiento",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: obtenerDigitoMasGrande(
                        _calculationPercentage().toInt()),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ), // Radio de los bordes
                      ),
                      height: 50,
                      child: Center(
                        child: Text(
                          ' ${(100 - (_calculationPercentage())).toStringAsFixed(1)}% libre',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${bytesToGigabytes(temp.free!).toStringAsFixed(0)} GB disponibles de ${bytesToGigabytes(temp.total!).toStringAsFixed(0)} GB ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
