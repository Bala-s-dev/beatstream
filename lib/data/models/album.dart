import 'package:equatable/equatable.dart';
import 'song.dart';

class Album extends Equatable {
  const Album({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.songs = const [],
  });

  final String id;
  final String title;
  final String imageUrl;
  final List<Song> songs;

  Album copyWith({List<Song>? songs}) {
    return Album(
      id: id,
      title: title,
      imageUrl: imageUrl,
      songs: songs ?? this.songs,
    );
  }

  @override
  List<Object?> get props => [id, title, imageUrl, songs];
}

class Artist extends Equatable {
  const Artist({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String imageUrl;

  @override
  List<Object?> get props => [id, name, imageUrl];
}
