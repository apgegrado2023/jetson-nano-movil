import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_prgrado/domain/entities/detection_history.dart';
import 'package:flutter_application_prgrado/presentation/pages/more_details_detection/more_details_detection_page.dart';
import 'package:intl/intl.dart';

class ItemWidget extends StatelessWidget {
  final DetectionHistoryEntity detectionHistoryEntity;
  ItemWidget({super.key, required this.detectionHistoryEntity});
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat(
      'd - MM - y',
    ).format(detectionHistoryEntity.registerDetection!);
    String hour = DateFormat(
      'HH:mm',
    ).format(detectionHistoryEntity.registerDetection!);
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(
          255,
          51,
          51,
          51,
        ), // Co
        borderRadius: BorderRadius.all(
          Radius.circular(10.0), // Radio de esquina
        ),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Detección tipo:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 10,
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
                          child: Text(
                            detectionHistoryEntity.typeDetection! == 1
                                ? 'Somnolencia'
                                : 'Distracción',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Fecha: " + formattedDate,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Hora: " + hour,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900),
                      ),
                    ]),
              ),
              Image.file(
                File(detectionHistoryEntity.listPath!.first),
                errorBuilder: ((context, error, stackTrace) {
                  return Image.asset(
                    width: 170,
                    height: 100,
                    'assets/images/NOdisponibleIMG.jpg',
                  );
                }),
                width: 170,
                height: 100,
              ),
            ],
          ),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MoreDetailsDetectionPage(
                                detectionHistoryEntity: detectionHistoryEntity,
                              )),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Mas detalles',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Colors.white,
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
//Color(0xFF7880CD), Color(0xFF6FC498)

