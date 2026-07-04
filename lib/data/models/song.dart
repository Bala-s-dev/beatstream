import 'package:equatable/equatable.dart';

/// A single track. Immutable + [Equatable] so Bloc/Cubit state comparisons
/// and `const` widget rebuild-skipping work correctly.
class Song extends Equatable {
  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.imageUrl,
    this.durationSeconds = 210,
    this.isFavorite = false,
  });

  final String id;
  final String title;
  final String artist;
  final String imageUrl;
  final int durationSeconds;
  final bool isFavorite;

  Song copyWith({bool? isFavorite}) {
    return Song(
      id: id,
      title: title,
      artist: artist,
      imageUrl: imageUrl,
      durationSeconds: durationSeconds,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [id, title, artist, imageUrl, isFavorite];
}
