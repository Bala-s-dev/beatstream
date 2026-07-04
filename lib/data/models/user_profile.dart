import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.name,
    required this.email,
    required this.avatarUrl,
    this.playlistsCount = 0,
    this.followersCount = 0,
  });

  final String name;
  final String email;
  final String avatarUrl;
  final int playlistsCount;
  final int followersCount;

  @override
  List<Object?> get props => [
    name,
    email,
    avatarUrl,
    playlistsCount,
    followersCount,
  ];
}
