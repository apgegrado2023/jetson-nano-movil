import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';

class MemoryWidget extends StatelessWidget {
  final MemoryInfo info;
  const MemoryWidget({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    print(info.available);
    print(info.percentUsed);
    print(info.total);
    double percentUsed = ((info.total - info.available) / info.total) * 100;
    List<PieChartSectionData> showingSections() {
      return List.generate(2, (i) {
        final radius = 50.0;
        const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Color.fromARGB(255, 74, 64, 161),
              value: double.parse(info.available.toString()),
              title: "${100 - info.percentUsed}%",
              radius: radius,
              titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
                shadows: shadows,
              ),
            );
          case 1:
            return PieChartSectionData(
              color: Color.fromARGB(255, 236, 153, 58),
              value: double.parse((info.total - info.available).toString()),
              title: "${info.percentUsed}%",
              radius: radius,
              titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
                shadows: shadows,
              ),
            );

          default:
            throw Error();
        }
      });
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
            "Memoria RAM",
            style: TextStyle(
                fontSize: 17,
                color: Color.fromARGB(255, 74, 64, 161),
                fontWeight: FontWeight.bold),
          ),
          AspectRatio(
            aspectRatio: 1.8,
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
                        centerSpaceRadius: 40,
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
                      color: Color.fromARGB(255, 236, 153, 58),
                      text: 'Uso',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: Color.fromARGB(255, 74, 64, 161),
                      text: 'Libre',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
            color: textColor,
          ),
        )
      ],
    );
  }
}
