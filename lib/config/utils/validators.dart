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

  static String? Function(String?) get validationPassword => (String? value) {
        if (!InputValidators.isRequired(value)) {
          return "No se permite vacios";
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
