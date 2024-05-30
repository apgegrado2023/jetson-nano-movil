import 'package:flutter_application_prgrado/core/app/cubit/notification_app_cubit.dart';

class NotificationSyn {
  static NotificationInfo get noConnection {
    return NotificationInfo(
      NotificationType.error,
      title: 'Sin conexión',
      message: 'No hay conexión!',
    );
  }

  static NotificationInfo get okConnection {
    return NotificationInfo(
      NotificationType.success,
      title: 'Con conexión',
      message: 'Si hay conexión!',
    );
  }

  static NotificationInfo get errorGetData {
    return NotificationInfo(
      NotificationType.error,
      title: 'Erro',
      message: 'Error al obtener los datos!',
    );
  }
}
