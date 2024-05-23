import 'input_validators.dart';

abstract class Validators {
  static String? Function(String?) get validationEmail => (String? value) {
        if (!InputValidators.isRequired(value)) {
          return "No se permite vacios";
        }

        if (!InputValidators.isEmail(value)) {
          return "Introduzca un email valido";
        }
        return null;
      };
  static String? Function(String?) get validationNumber => (String? value) {
        if (!InputValidators.isRequired(value)) {
          return "No se permite vacío";
        }

        if (!InputValidators.isNumeric(value)) {
          return "Introduzca un número válido";
        }
        return null;
      };

  static String? Function(String?) get validationNumberDouble =>
      (String? value) {
        if (!InputValidators.isRequired(value)) {
          return "No se permite vacío";
        }

        if (!InputValidators.isDouble(value)) {
          return "Introduzca un número válido";
        }
        return null;
      };

  static String? Function(String?) get validationPassword =>
      (String? contrasena) {
        if (!InputValidators.isRequired(contrasena)) {
          return "No se permite vacios";
        }

        if (contrasena!.length < 8) {
          return 'La contraseña debe tener al menos 8 caracteres';
        }

        // Contiene al menos una letra mayúscula
        if (!contrasena.contains(RegExp(r'[A-Z]'))) {
          return "La contraseña debe contener al menos una letra mayúscula";
        }

        // Contiene al menos una letra minúscula
        if (!contrasena.contains(RegExp(r'[a-z]'))) {
          return "La contraseña debe contener al menos una letra minúscula";
        }

        // Contiene al menos un número
        if (!contrasena.contains(RegExp(r'[0-9]'))) {
          return "La contraseña debe contener al menos un número";
        }

        // Contiene al menos un carácter especial
        if (!contrasena.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
          return "La contraseña debe contener al menos un carácter especial";
        }

        return null;
      };

  static String? Function(String?) get validationText => (String? value) {
        if (!InputValidators.isRequired(value)) {
          return "No se permite vacios";
        }
        return null;
      };

  static String? Function(String?) get validationPhone => (String? value) {
        if (!InputValidators.isRequired(value)) {
          return "No se permite vacios";
        }
        return null;
      };

  static String? Function(dynamic) get validationNull => (dynamic value) {
        if (value == null) {
          return "Este campo es necesario";
        }
        return null;
      };
}
