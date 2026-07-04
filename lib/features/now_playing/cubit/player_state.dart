import 'package:equatable/equatable.dart';

import 'package:beatstream/data/models/song.dart';

class PlayerState extends Equatable {
  const PlayerState({
    this.currentSong,
    this.queue = const [],
    this.currentIndex = -1,
    this.isPlaying = false,
    this.positionSeconds = 0,
    this.isShuffle = false,
    this.isRepeat = false,
  });

  final Song? currentSong;
  final List<Song> queue;
  final int currentIndex;
  final bool isPlaying;
  final int positionSeconds;
  final bool isShuffle;
  final bool isRepeat;

  bool get hasTrack => currentSong != null;

  int get durationSeconds => currentSong?.durationSeconds ?? 0;

  double get progress =>
      durationSeconds == 0 ? 0 : positionSeconds / durationSeconds;

  PlayerState copyWith({
    Song? currentSong,
    bool clearCurrentSong = false,
    List<Song>? queue,
    int? currentIndex,
    bool? isPlaying,
    int? positionSeconds,
    bool? isShuffle,
    bool? isRepeat,
  }) {
    return PlayerState(
      currentSong: clearCurrentSong ? null : (currentSong ?? this.currentSong),
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      isPlaying: isPlaying ?? this.isPlaying,
      positionSeconds: positionSeconds ?? this.positionSeconds,
      isShuffle: isShuffle ?? this.isShuffle,
      isRepeat: isRepeat ?? this.isRepeat,
    );
  }

  @override
  List<Object?> get props => [
        currentSong,
        queue,
        currentIndex,
        isPlaying,
        positionSeconds,
        isShuffle,
        isRepeat,
      ];
}
