import 'package:equatable/equatable.dart';

import '../../../data/models/notification_setting.dart';

class NotificationsState extends Equatable {
  const NotificationsState({this.settings = const [], this.isLoading = true});

  final List<NotificationSetting> settings;
  final bool isLoading;

  NotificationsState copyWith({
    List<NotificationSetting>? settings,
    bool? isLoading,
  }) {
    return NotificationsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [settings, isLoading];
}
