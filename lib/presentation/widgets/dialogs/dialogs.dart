import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/config/utils/my_colors.dart';

import '../../../data/models/error_dialog_data.dart';
import '../../../data/models/good_dialog_data.dart';
import '../inputs/custom_button.dart';

class ErrorDialog extends StatelessWidget {
  final ErrorDialogData errorDialogData;

  const ErrorDialog({super.key, required this.errorDialogData});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      iconPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.only(
        left: 40,
        right: 40,
        bottom: 40,
      ),
      icon: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Container()),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 40),
              child: Icon(
                Icons.error,
                size: 50,
                color: Colors.redAccent,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
      title: Text(
        errorDialogData.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.redAccent,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        errorDialogData.message,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black54),
      ),
      actions: <Widget>[
        CustomButton(
          height: 50,
          textButton: errorDialogData.textButton,
          onPressed: errorDialogData.onPressed,
          colorButton: Colors.redAccent,
        )
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}

class GoodDialog extends StatelessWidget {
  final GoodDialogData goodDialogData;

  const GoodDialog({
    super.key,
    required this.goodDialogData,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      iconPadding: EdgeInsets.only(top: 40, bottom: 20),
      actionsPadding: EdgeInsets.only(
        left: 40,
        right: 40,
        bottom: 40,
      ),
      icon: Icon(
        Icons.task_alt,
        size: 50,
        color: CustomColorPrimary().materialColor,
      ),
      title: Text(
        goodDialogData.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: CustomColorPrimary().materialColor,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        goodDialogData.message,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black54),
      ),
      actions: <Widget>[
        CustomButton(
          height: 50,
          textButton: goodDialogData.textButton,
          onPressed: goodDialogData.onPressed,
        )
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}

abstract class Dialogs {
  static late BuildContext _context;

  static void showErrorMessage(
      BuildContext context, ErrorDialogData errorDialogData) {
    _context = context;
    showDialog(
      context: context,
      barrierDismissible: errorDialogData.barrierDismissible,
      builder: (BuildContext context) {
        return ErrorDialog(errorDialogData: errorDialogData);
      },
    );
  }

  static void showGoodMessage(
      BuildContext context, GoodDialogData goodDialogData) {
    _context = context;
    showDialog(
      context: context,
      barrierDismissible: goodDialogData.barrierDismissible,
      builder: (BuildContext context) {
        return GoodDialog(goodDialogData: goodDialogData);
      },
    );
  }

  static void close() {
    Navigator.pop(_context);
  }
}

abstract class DialogsBottom {
  static late BuildContext _context;
  static void showModalBottom(BuildContext context, Widget child) {
    _context = context;
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (_) {
        return child;
      },
    );
  }

  static void close() {
    Navigator.pop(_context);
  }
}
