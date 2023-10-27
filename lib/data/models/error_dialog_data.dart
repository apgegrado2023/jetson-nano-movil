class ErrorDialogData {
  final String message;
  final String title;
  final String textButton;
  final Function() onPressed;
  final bool barrierDismissible;

  ErrorDialogData(
    this.message,
    this.title,
    this.textButton,
    this.onPressed,
    this.barrierDismissible,
  );
}
