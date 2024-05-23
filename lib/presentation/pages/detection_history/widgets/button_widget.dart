import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ButtonOptionWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final void Function()? ontap;
  const ButtonOptionWidget({
    super.key,
    required this.text,
    required this.isSelected,
    required this.ontap,
    this.borderRadiusGeometry,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(
              255,
              51,
              51,
              51,
            ), // Color del borde
            width: 1.0, // Ancho del borde
          ),

          borderRadius: borderRadiusGeometry,
          color: isSelected
              ? const Color.fromARGB(
                  255,
                  51,
                  51,
                  51,
                )
              : null, // Cambia el color del contenedor según lo necesites
        ),
        padding: EdgeInsets.all(10),
        child: InkWell(
          onTap: ontap,
          child: Column(
            children: [
              Container(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
