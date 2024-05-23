import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_prgrado/data/models/prototype/information_system.dart';
import 'package:flutter_application_prgrado/domain/entities/information_system.dart';

class MemorySwapWidget extends StatelessWidget {
  final MemoryInfoSwapEntity memoryInfoSwap;
  const MemorySwapWidget({super.key, required this.memoryInfoSwap});
  double bytesToGigabytes(int bytes) {
    return bytes / (1024 * 1024 * 1024);
  }

  @override
  Widget build(BuildContext context) {
    print(memoryInfoSwap.free);
    print(memoryInfoSwap.percentUsed);
    print(memoryInfoSwap.total);
    double percentUsed = ((memoryInfoSwap.total! - memoryInfoSwap.free!) /
            memoryInfoSwap.total!) *
        100;

    double swapR = double.parse(percentUsed.toStringAsFixed(2));
    return Container(
      height: 131,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF6FC498), // C
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
                color: Color.fromARGB(255, 96, 182, 137),
              ),
              child: Icon(
                Icons.memory_sharp,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Mem. SWAP",
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
                "$swapR %",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
          ]),
    );
  }
}
