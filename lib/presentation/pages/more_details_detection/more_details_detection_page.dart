import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/domain/entities/detection_history.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class MoreDetailsDetectionPage extends StatelessWidget {
  final DetectionHistoryEntity detectionHistoryEntity;
  const MoreDetailsDetectionPage(
      {super.key, required this.detectionHistoryEntity});

  Widget _widgetImage(String patch) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 350,
      height: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: Image.file(
          File(patch),
          fit: BoxFit.fitWidth,

          //height: 90,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/NOdisponibleIMG.jpg',
              width: double.infinity,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat(
      'd - MM - y',
    ).format(detectionHistoryEntity.registerDetection!);
    String hour = DateFormat(
      'HH:mm',
    ).format(detectionHistoryEntity.registerDetection!);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detalles de la detección'),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        backgroundColor: Color(0xFF151515), //
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: detectionHistoryEntity.listPath!.length,
                    itemBuilder: ((context, index) {
                      return _widgetImage(
                          detectionHistoryEntity.listPath![index]);
                    })),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Detección tipo:",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: detectionHistoryEntity.typeDetection! == 1
                      ? Color(0xFF6FC498)
                      : Color(0xFF7880CD),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0), // Radio de esquina
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        detectionHistoryEntity.typeDetection! == 1
                            ? 'Somnolencia'
                            : 'Distracción',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      detectionHistoryEntity.typeDetection! == 1
                          ? Lottie.asset(
                              'assets/lottie/Animation1708965158430.json',
                              width: 80,
                              height: 80,
                            )
                          : Lottie.asset(
                              'assets/lottie/Animation - 1708966836688.json',
                              width: 80,
                              height: 80,
                            )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(
                          255,
                          51,
                          51,
                          51,
                        ),
                        //border: Border.all(color: Colors.white30),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0), // Radio de esquina
                        ),
                      ),
                      child: Text(
                        "Fecha: " + formattedDate,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(
                          255,
                          51,
                          51,
                          51,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0), // Radio de esquina
                        ),
                      ),
                      child: Text(
                        "Hora: " + hour,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color.fromARGB(
                    255,
                    51,
                    51,
                    51,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0), // Radio de esquina
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Animation - 1708965158430.json

                    Text(
                      "Descripción:",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      detectionHistoryEntity.description!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              //color: Color(0xFF151515),
            ]),
          ),
        ),
      ),
    );
  }
}
