import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/config/utils/my_colors.dart';
import 'package:flutter_application_prgrado/data/models/warning_dialog_data.dart';

import '../inputs/custom_button.dart';

class ErrorDialog extends StatelessWidget {
  final DialogData errorDialogData;

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
          colorTextButton: Colors.white,
        )
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}

class WarningDialog extends StatelessWidget {
  final DialogData warningDialogData;

  const WarningDialog({super.key, required this.warningDialogData});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
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
                Icons.warning,
                size: 50,
                color: Colors.orangeAccent,
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
        warningDialogData.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.orangeAccent,
        ),
        textAlign: TextAlign.center,
      ),
      content: Container(
        child: Text(
          warningDialogData.message,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54),
        ),
      ),
      actions: <Widget>[
        CustomButton(
          height: 50,
          textButton: warningDialogData.textButton,
          onPressed: warningDialogData.onPressed,
          colorButton: Colors.orangeAccent,
          colorTextButton: Colors.white,
        )
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}

class GoodDialog extends StatelessWidget {
  final DialogData goodDialogData;

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
      BuildContext context, DialogData errorDialogData) {
    _context = context;
    showDialog(
      context: context,
      barrierDismissible: errorDialogData.barrierDismissible,
      builder: (BuildContext context) {
        return ErrorDialog(errorDialogData: errorDialogData);
      },
    );
  }

  static void showGoodMessage(BuildContext context, DialogData goodDialogData) {
    _context = context;
    showDialog(
      context: context,
      barrierDismissible: goodDialogData.barrierDismissible,
      builder: (BuildContext context) {
        return GoodDialog(goodDialogData: goodDialogData);
      },
    );
  }

  static void showWarningMessage(
      BuildContext context, DialogData warningDialogData) {
    _context = context;
    showDialog(
      context: context,
      barrierDismissible: warningDialogData.barrierDismissible,
      builder: (BuildContext context) {
        return WarningDialog(warningDialogData: warningDialogData);
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
