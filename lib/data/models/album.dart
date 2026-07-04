import 'package:equatable/equatable.dart';

class Album extends Equatable {
  const Album({required this.id, required this.imageUrl, this.title = ''});

  final String id;
  final String imageUrl;
  final String title;

  @override
  List<Object?> get props => [id, imageUrl, title];
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
