import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? elevation;
  final TextAlign? textAlign;
  final List<Widget>? actions;
  final Color? background;
  final Color? colorIcon;

  const AppBarCustom({
    Key? key,
    this.textAlign,
    required this.title,
    this.elevation,
    this.actions,
    this.colorIcon,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        textAlign: textAlign,
      ),
      iconTheme: IconThemeData(color: colorIcon),
      actions: actions,
      elevation: elevation,
      backgroundColor: background,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
