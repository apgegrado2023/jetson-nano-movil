part of 'notification_app_cubit.dart';

class NotificationAppState extends Equatable {
  const NotificationAppState({
    this.notification = const NotificationInfo.empty(),
  });
  final NotificationInfo notification;

  NotificationAppState copyWith({NotificationInfo? notification}) {
    return NotificationAppState(
      notification: notification ?? this.notification,
    );
  }

  @override
  List<Object> get props => [notification];
}

enum NotificationType { success, error, info }

class NotificationInfo {
  NotificationInfo(
    this.notificationType, {
    required this.title,
    required this.message,
  });

  const NotificationInfo.empty()
      : notificationType = NotificationType.info,
        title = '',
        message = '';

  final NotificationType notificationType;
  final String title;
  final String message;
}
