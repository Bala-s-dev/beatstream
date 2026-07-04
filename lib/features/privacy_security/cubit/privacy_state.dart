import 'package:equatable/equatable.dart';

class PrivacyState extends Equatable {
  const PrivacyState({this.privateSession = false, this.isLoading = true});

  final bool privateSession;
  final bool isLoading;

  PrivacyState copyWith({bool? privateSession, bool? isLoading}) {
    return PrivacyState(
      privateSession: privateSession ?? this.privateSession,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [privateSession, isLoading];
}
