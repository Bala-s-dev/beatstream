//favorites_state
import 'package:equatable/equatable.dart';
import '../../../data/models/song.dart';

enum FavoritesStatus { initial, loading, success, failure }

class FavoritesState extends Equatable {
  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.songs = const [],
    this.errorMessage,
  });

  final FavoritesStatus status;
  final List<Song> songs;
  final String? errorMessage;

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<Song>? songs,
    String? errorMessage,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      songs: songs ?? this.songs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, songs, errorMessage];
}
