import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/user_repository.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({required UserRepository userRepository})
    : _userRepository = userRepository,
      super(const NotificationsState()) {
    _load();
  }

  final UserRepository _userRepository;

  Future<void> _load() async {
    final settings = await _userRepository.getNotificationSettings();
    emit(NotificationsState(settings: settings, isLoading: false));
  }

  Future<void> toggle(String id) async {
    await _userRepository.toggleNotification(id);
    emit(
      state.copyWith(
        settings: [
          for (final setting in state.settings)
            if (setting.id == id)
              setting.copyWith(enabled: !setting.enabled)
            else
              setting,
        ],
      ),
    );
  }
}
