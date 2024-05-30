import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_app_state.dart';

class NotificationAppCubit extends Cubit<NotificationAppState> {
  NotificationAppCubit() : super(NotificationAppState());

  void onChangeNotification(NotificationInfo notification) {
    emit(state.copyWith(notification: notification));
  }
}

class NotificationInteractor {
  static NotificationAppCubit _bloc = NotificationAppCubit();

  static NotificationAppCubit get bloc => _bloc;

  static void onChangeNotification(NotificationInfo notificationInfo) {
    _bloc.onChangeNotification(notificationInfo);
  }
}
