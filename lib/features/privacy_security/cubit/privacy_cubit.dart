import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/user_repository.dart';
import 'privacy_state.dart';

class PrivacyCubit extends Cubit<PrivacyState> {
  PrivacyCubit({required UserRepository userRepository})
    : _userRepository = userRepository,
      super(const PrivacyState()) {
    _load();
  }

  final UserRepository _userRepository;

  Future<void> _load() async {
    final enabled = await _userRepository.getPrivateSessionEnabled();
    emit(state.copyWith(privateSession: enabled, isLoading: false));
  }

  Future<void> togglePrivateSession() async {
    final updated = await _userRepository.togglePrivateSession();
    emit(state.copyWith(privateSession: updated));
  }
}
