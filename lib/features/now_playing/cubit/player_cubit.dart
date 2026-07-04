import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beatstream/data/models/song.dart';
import 'package:beatstream/data/repositories/music_repository.dart';
import 'player_state.dart';

/// Global playback state, deliberately kept at the app root (see
/// `main.dart`) so both the persistent mini-player and the full "Now
/// Playing" screen stay in sync no matter where they're mounted.
///
/// This is a UI-only simulation (ticking a position timer) - swap the body
/// of [play]/[togglePlayPause]/[seekTo] for real calls to an audio engine
/// (e.g. `just_audio`) when wiring up an actual backend/CDN.
class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit({required MusicRepository musicRepository})
      : _musicRepository = musicRepository,
        super(const PlayerState());

  final MusicRepository _musicRepository;
  Timer? _ticker;

  void play(Song song, {List<Song> queue = const []}) {
    _ticker?.cancel();
    final effectiveQueue = queue.isEmpty ? [song] : queue;
    final index = effectiveQueue.indexWhere((s) => s.id == song.id);
    emit(
      state.copyWith(
        currentSong: song,
        queue: effectiveQueue,
        currentIndex: index < 0 ? 0 : index,
        isPlaying: true,
        positionSeconds: 0,
      ),
    );
    _startTicker();
  }

  void togglePlayPause() {
    if (!state.hasTrack) return;
    final bool nowPlaying = !state.isPlaying;
    emit(state.copyWith(isPlaying: nowPlaying));
    if (nowPlaying) {
      _startTicker();
    } else {
      _ticker?.cancel();
    }
  }

  void seekTo(double fraction) {
    if (!state.hasTrack) return;
    final int newPosition = (state.durationSeconds * fraction).round().clamp(
          0,
          state.durationSeconds,
        );
    emit(state.copyWith(positionSeconds: newPosition));
  }

  void skipNext() => _skip(1);

  void skipPrevious() {
    // If we're more than 3s into the track, "previous" restarts it -
    // standard music-player UX - otherwise it moves to the prior track.
    if (state.positionSeconds > 3) {
      emit(state.copyWith(positionSeconds: 0));
      return;
    }
    _skip(-1);
  }

  void _skip(int delta) {
    if (state.queue.isEmpty) return;
    final int nextIndex = (state.currentIndex + delta) % state.queue.length;
    final int safeIndex =
        nextIndex < 0 ? state.queue.length + nextIndex : nextIndex;
    play(state.queue[safeIndex], queue: state.queue);
  }

  void toggleShuffle() => emit(state.copyWith(isShuffle: !state.isShuffle));

  void toggleRepeat() => emit(state.copyWith(isRepeat: !state.isRepeat));

  Future<void> toggleFavoriteCurrent() async {
    final Song? current = state.currentSong;
    if (current == null) return;
    final Song updated = await _musicRepository.toggleFavorite(current.id);
    emit(state.copyWith(currentSong: updated));
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!state.isPlaying || !state.hasTrack) return;
      final int next = state.positionSeconds + 1;
      if (next >= state.durationSeconds) {
        if (state.isRepeat) {
          emit(state.copyWith(positionSeconds: 0));
        } else {
          skipNext();
        }
      } else {
        emit(state.copyWith(positionSeconds: next));
      }
    });
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}
