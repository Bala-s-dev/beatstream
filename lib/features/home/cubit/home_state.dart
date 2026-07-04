//home_state
import 'package:equatable/equatable.dart';
import '../../../data/models/album.dart';
import '../../../data/models/song.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.languages = const [],
    this.selectedLanguage = 'English',
    this.trendingSongs = const [],
    this.popularAlbums = const [],
    this.artists = const [],
    this.recentlyPlayed = const [],
    this.errorMessage,
  });

  final HomeStatus status;
  final List<String> languages;
  final String selectedLanguage;
  final List<Song> trendingSongs;
  final List<Album> popularAlbums;
  final List<Artist> artists;
  final List<Song> recentlyPlayed;
  final String? errorMessage;

  HomeState copyWith({
    HomeStatus? status,
    List<String>? languages,
    String? selectedLanguage,
    List<Song>? trendingSongs,
    List<Album>? popularAlbums,
    List<Artist>? artists,
    List<Song>? recentlyPlayed,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      languages: languages ?? this.languages,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      trendingSongs: trendingSongs ?? this.trendingSongs,
      popularAlbums: popularAlbums ?? this.popularAlbums,
      artists: artists ?? this.artists,
      recentlyPlayed: recentlyPlayed ?? this.recentlyPlayed,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    languages,
    selectedLanguage,
    trendingSongs,
    popularAlbums,
    artists,
    recentlyPlayed,
    errorMessage,
  ];
}
