//favorites_cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/music_repository.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required MusicRepository musicRepository})
    : _musicRepository = musicRepository,
      super(const FavoritesState()) {
    loadFavorites();
  }

  final MusicRepository _musicRepository;

  Future<void> loadFavorites() async {
    emit(state.copyWith(status: FavoritesStatus.loading));
    try {
      final favorites = await _musicRepository.getFavorites();
      emit(state.copyWith(status: FavoritesStatus.success, songs: favorites));
    } catch (_) {
      emit(
        state.copyWith(
          status: FavoritesStatus.failure,
          errorMessage: 'Could not load your favorites.',
        ),
      );
    }
  }

  /// Removes the song from the favorites list. Called *after* the tile's
  /// own exit animation finishes (see `FavoriteSongTile`) so the UI removal
  /// is visually smooth rather than an abrupt jump-cut.
  Future<void> unfavorite(String songId) async {
    await _musicRepository.toggleFavorite(songId);
    emit(
      state.copyWith(
        songs: state.songs.where((s) => s.id != songId).toList(),
      ),
    );
  }
}
