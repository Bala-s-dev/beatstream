import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/user_repository.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required UserRepository userRepository})
    : _userRepository = userRepository,
      super(const SettingsState()) {
    _load();
  }

  final UserRepository _userRepository;

  Future<void> _load() async {
    final wifiOnly = await _userRepository.getWifiOnlyDownloads();
    emit(state.copyWith(wifiOnlyDownloads: wifiOnly, isLoading: false));
  }

  Future<void> toggleWifiOnlyDownloads() async {
    final updated = await _userRepository.toggleWifiOnlyDownloads();
    emit(state.copyWith(wifiOnlyDownloads: updated));
  }
}
