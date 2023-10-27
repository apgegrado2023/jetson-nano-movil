import 'package:intl/intl.dart';

abstract class Functions {
  static String generarContrasena(String nombre, String fecha) {
    String contrasena = nombre.substring(0, 4) + fecha.substring(0, 4);
    return contrasena;
  }

  static String generarContrasena2(String nombre, String fecha) {
    // Obtén la fecha y hora actual
    DateTime now = DateTime.now();

    // Formatea la fecha y hora en un formato deseado (por ejemplo, "yyyyMMddHHmm")
    String formattedDate = DateFormat('yyyyMMddHHmm').format(now);

    // Combina el nombre, la fecha y la hora formateada para crear la contraseña
    String contrasena =
        nombre.substring(0, 4) + fecha.substring(0, 4) + formattedDate;

    // Asegúrate de que la contraseña tenga exactamente 8 caracteres
    if (contrasena.length > 8) {
      contrasena = contrasena.substring(0, 8);
    }

    return contrasena;
  }
}
