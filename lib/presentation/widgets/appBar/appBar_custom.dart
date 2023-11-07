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
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Container(
              height: 100,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    10), // Ajusta este valor para cambiar el radio de los bordes
                color: Color.fromARGB(255, 51, 51,
                    51), // Cambia el color del contenedor según lo necesites
              ),
              child: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ), // Icono del menú personalizado
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Abre el menú lateral
            },
          );
        },
      ),
      backgroundColor: background,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
