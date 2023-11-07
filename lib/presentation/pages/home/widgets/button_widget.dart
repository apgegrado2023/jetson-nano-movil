import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final void Function()? ontap;
  const ButtonWidget({
    super.key,
    required this.text,
    required this.isSelected,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: !isSelected
                  ? Border.all(
                      color: Color.fromARGB(
                        255,
                        51,
                        51,
                        51,
                      ), // Color del borde
                      width: 1.0, // Ancho del borde
                    )
                  : null,
              borderRadius: BorderRadius.circular(
                  30), // Ajusta este valor para cambiar el radio de los bordes
              color: isSelected
                  ? const Color.fromARGB(
                      255,
                      51,
                      51,
                      51,
                    )
                  : null, // Cambia el color del contenedor según lo necesites
            ),
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          isSelected
              ? Icon(
                  Icons.circle,
                  size: 7,
                  color: Color.fromARGB(255, 96, 109, 204),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
