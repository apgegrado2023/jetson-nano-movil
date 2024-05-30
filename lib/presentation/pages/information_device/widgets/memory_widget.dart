import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';
import 'package:flutter_application_prgrado/domain/entities/information_system.dart';

class MemoryWidget extends StatelessWidget {
  final MemoryInfoEntity info;
  const MemoryWidget({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    print(info.available);
    print(info.percentUsed);
    print(info.total);
    double percentUsed = ((info.total! - info.available!) / info.total!) * 100;
    List<PieChartSectionData> showingSections() {
      return List.generate(2, (i) {
        final radius = 50.0;
        const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Color.fromARGB(255, 255, 255, 255),
              value: double.parse(info.available.toString()),
              title: "${(100 - info.percentUsed).toStringAsFixed(1)}%",
              radius: radius,
              titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            );
          case 1:
            return PieChartSectionData(
              color: Color.fromARGB(255, 138, 221, 181),
              value: double.parse((info.total! - info.available!).toString()),
              title: "${info.percentUsed.toStringAsFixed(1)}%",
              radius: radius,
              titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 10, 10, 10),
              ),
            );

          default:
            throw Error();
        }
      });
    }

    return Container(
      height: 290,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(51, 51, 51, 1), //
        borderRadius:
            BorderRadius.all(Radius.circular(10.0)), // Radio de los bordes
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    10), // Ajusta este valor para cambiar el radio de los bordes
                color: Color.fromARGB(255, 43, 42, 42)),
            child: Icon(
              Icons.memory,
              color: Colors.white,
            ),
          ), //
          SizedBox(
            height: 15,
          ),
          Text(
            "Memoria RAM",
            style: TextStyle(
                fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          AspectRatio(
            aspectRatio: 1.5,
            child: Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 10,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    Indicator(
                      color: Color.fromARGB(255, 138, 221, 181),
                      text: 'Uso',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Color.fromARGB(255, 255, 255, 255),
                      text: 'Libre',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                  ],
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
          Text(
            "${bytesToGigabytes(info.available!).toStringAsFixed(2)} GB disponibles de ${bytesToGigabytes(info.total!).toStringAsFixed(2)} GB ",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  double bytesToGigabytes(int bytes) {
    return bytes / (1024 * 1024 * 1024);
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
