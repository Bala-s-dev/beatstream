import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/debouncer.dart';
import '../../../data/repositories/music_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required MusicRepository musicRepository})
    : _musicRepository = musicRepository,
      super(const SearchState());

  final MusicRepository _musicRepository;
  final Debouncer _debouncer = Debouncer(
    duration: const Duration(milliseconds: 300),
  );

  /// Bumped on every keystroke; a search that resolves after the query has
  /// since changed is discarded, preventing stale results from a slow
  /// earlier request from overwriting a newer, faster one.
  int _requestId = 0;

  void queryChanged(String value) {
    emit(state.copyWith(query: value));

    if (value.trim().isEmpty) {
      _debouncer.dispose();
      emit(state.copyWith(status: SearchStatus.idle, results: const []));
      return;
    }

    emit(state.copyWith(status: SearchStatus.loading));
    _debouncer(() => _search(value));
  }

  Future<void> _search(String query) async {
    final int requestId = ++_requestId;
    final results = await _musicRepository.search(query);
    if (requestId != _requestId || isClosed) return;

    emit(
      state.copyWith(
        status: results.isEmpty ? SearchStatus.empty : SearchStatus.success,
        results: results,
      ),
    );
  }

  @override
  Future<void> close() {
    _debouncer.dispose();
    return super.close();
  }
}
