import 'package:equatable/equatable.dart';

class NotificationSetting extends Equatable {
  const NotificationSetting({
    required this.id,
    required this.title,
    required this.description,
    required this.enabled,
  });

  final String id;
  final String title;
  final String description;
  final bool enabled;

  NotificationSetting copyWith({bool? enabled}) {
    return NotificationSetting(
      id: id,
      title: title,
      description: description,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  List<Object?> get props => [id, title, description, enabled];
}
