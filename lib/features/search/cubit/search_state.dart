import 'package:equatable/equatable.dart';

import '../../../data/models/song.dart';

enum SearchStatus { idle, loading, success, empty, failure }

class SearchState extends Equatable {
  const SearchState({
    this.query = '',
    this.status = SearchStatus.idle,
    this.results = const [],
  });

  final String query;
  final SearchStatus status;
  final List<Song> results;

  SearchState copyWith({
    String? query,
    SearchStatus? status,
    List<Song>? results,
  }) {
    return SearchState(
      query: query ?? this.query,
      status: status ?? this.status,
      results: results ?? this.results,
    );
  }

  @override
  List<Object?> get props => [query, status, results];
}
