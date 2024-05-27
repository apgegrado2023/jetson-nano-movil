import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Loading {
  static late BuildContext _context;
  static void show(BuildContext context) {
    _context = context;

    showCupertinoModalPopup(
      context: context,
      builder: (_) => SafeArea(
          child: PopScope(
        child: Center(
          child: Container(
            color: Colors.black12,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
        ),
      )
          //onWillPop: () async => false),
          ),
    );
  }

  static void showText(context, text) {
    _context = context;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 40,
            //color: Color.fromARGB(255, 255, 255, 255),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Text(
                  text,
                  textAlign: TextAlign.center,
                ))
              ],
            ),
          ),
        );
      },
    );
  }

  static void close() {
    Navigator.pop(_context);
  }
}
