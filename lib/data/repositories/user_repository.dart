import '../models/notification_setting.dart';
import '../models/user_profile.dart';

abstract class UserRepository {
  Future<UserProfile> getProfile();

  Future<List<NotificationSetting>> getNotificationSettings();

  Future<NotificationSetting> toggleNotification(String id);

  Future<bool> getPrivateSessionEnabled();

  Future<bool> togglePrivateSession();

  Future<bool> getWifiOnlyDownloads();

  Future<bool> toggleWifiOnlyDownloads();
}

class MockUserRepository implements UserRepository {
  final Duration _latency = const Duration(milliseconds: 400);

  final UserProfile _profile = const UserProfile(
    name: 'Dharun',
    email: 'dharun@gmail.com',
    avatarUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBmwUJI6h8SHZ-P8nvrzwFWUMWaoB0cmEwxYMuesyQaOsn4Mxh2Ku95UOLexdgDhvnUjaJfr6DBmyLbF09OOlLqmiQLtGjRAzW6fIhYLLcZz8Cmz1IYhUemQmyDFUp5RGF5LSkORawoZpXEPdmXWGTSApZgpT82CVSCh0CltfKW-X3P20DmO2ptExiT4OTGBq7AJu2gxZg08PQ3koSsuElOPNtu_IvsjhDz3qdtAANEdHYcROtG4-2OLpk3kbtVM5Hlpx-3sPqR8SIOLw',
    playlistsCount: 24,
    followersCount: 842,
  );

  List<NotificationSetting> _notificationSettings = const [
    NotificationSetting(
      id: 'new_releases',
      title: 'New Releases',
      description: 'Get notified when followed artists drop new music.',
      enabled: true,
    ),
    NotificationSetting(
      id: 'playlist_updates',
      title: 'Playlist Updates',
      description: 'Updates to your favorite playlists.',
      enabled: false,
    ),
    NotificationSetting(
      id: 'recommendations',
      title: 'Recommendations',
      description: 'Discover music based on your taste.',
      enabled: true,
    ),
  ];

  bool _privateSession = false;
  bool _wifiOnly = true;

  @override
  Future<UserProfile> getProfile() async {
    await Future.delayed(_latency);
    return _profile;
  }

  @override
  Future<List<NotificationSetting>> getNotificationSettings() async {
    await Future.delayed(_latency);
    return List.unmodifiable(_notificationSettings);
  }

  @override
  Future<NotificationSetting> toggleNotification(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    late NotificationSetting updated;
    _notificationSettings = _notificationSettings.map((setting) {
      if (setting.id == id) {
        updated = setting.copyWith(enabled: !setting.enabled);
        return updated;
      }
      return setting;
    }).toList();
    return updated;
  }

  @override
  Future<bool> getPrivateSessionEnabled() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _privateSession;
  }

  @override
  Future<bool> togglePrivateSession() async {
    await Future.delayed(const Duration(milliseconds: 150));
    _privateSession = !_privateSession;
    return _privateSession;
  }

  @override
  Future<bool> getWifiOnlyDownloads() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _wifiOnly;
  }

  @override
  Future<bool> toggleWifiOnlyDownloads() async {
    await Future.delayed(const Duration(milliseconds: 150));
    _wifiOnly = !_wifiOnly;
    return _wifiOnly;
  }
}
