import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  const SettingsState({this.wifiOnlyDownloads = true, this.isLoading = true});

  final bool wifiOnlyDownloads;
  final bool isLoading;

  SettingsState copyWith({bool? wifiOnlyDownloads, bool? isLoading}) {
    return SettingsState(
      wifiOnlyDownloads: wifiOnlyDownloads ?? this.wifiOnlyDownloads,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [wifiOnlyDownloads, isLoading];
}
