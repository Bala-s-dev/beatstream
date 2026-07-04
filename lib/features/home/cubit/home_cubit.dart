//home_cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/album.dart';
import '../../../data/models/song.dart';
import '../../../data/repositories/music_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required MusicRepository musicRepository})
    : _musicRepository = musicRepository,
      super(const HomeState()) {
    loadHome();
  }

  final MusicRepository _musicRepository;

  Future<void> loadHome() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final List<String> languages = await _musicRepository.getLanguages();
      final List<Song> trending = await _musicRepository.getTrendingSongs();
      final List<Album> albums = await _musicRepository.getPopularAlbums();
      final List<Artist> artists = await _musicRepository.getArtists();
      final List<Song> recent = await _musicRepository.getRecentlyPlayed();

      emit(
        state.copyWith(
          status: HomeStatus.success,
          languages: languages,
          trendingSongs: trending,
          popularAlbums: albums,
          artists: artists,
          recentlyPlayed: recent,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: 'Could not load your feed. Pull to refresh.',
        ),
      );
    }
  }

  void selectLanguage(String language) {
    emit(state.copyWith(selectedLanguage: language));
  }

  Future<void> refresh() => loadHome();
}
