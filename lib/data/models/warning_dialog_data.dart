import 'package:flutter_application_prgrado/data/models/good_dialog_data.dart';

class WarningDialogData {
  final String message;
  final String title;
  final String textButton;
  final Function() onPressed;
  final bool barrierDismissible;

  WarningDialogData(
    this.message,
    this.title,
    this.textButton,
    this.onPressed,
    this.barrierDismissible,
  );
}

class DialogData {
  final String message;
  final String title;
  final String textButton;
  final Function() onPressed;
  final bool barrierDismissible;

  // Constructor principal
  const DialogData({
    required this.message,
    required this.title,
    required this.textButton,
    required this.onPressed,
    required this.barrierDismissible,
  });

  const DialogData.empty()
      : message = '',
        title = '',
        textButton = '',
        onPressed = _emptyFunction,
        barrierDismissible = false;
  static void _emptyFunction() {}
}
