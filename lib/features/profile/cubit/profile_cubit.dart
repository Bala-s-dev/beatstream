import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/user_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required UserRepository userRepository})
    : _userRepository = userRepository,
      super(const ProfileState()) {
    loadProfile();
  }

  final UserRepository _userRepository;

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final profile = await _userRepository.getProfile();
      emit(state.copyWith(status: ProfileStatus.success, profile: profile));
    } catch (_) {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }
}
