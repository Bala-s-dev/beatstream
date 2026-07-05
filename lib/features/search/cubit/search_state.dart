import 'package:equatable/equatable.dart';

import '../../../data/models/album.dart';
import '../../../data/models/song.dart';

enum SearchStatus { idle, loading, success, empty, failure }

class SearchState extends Equatable {
  const SearchState({
    this.query = '',
    this.status = SearchStatus.idle,
    this.results = const [],
    this.albumResults = const [],
  });

  final String query;
  final SearchStatus status;
  final List<Song> results;
  final List<Album> albumResults;

  SearchState copyWith({
    String? query,
    SearchStatus? status,
    List<Song>? results,
    List<Album>? albumResults,
  }) {
    return SearchState(
      query: query ?? this.query,
      status: status ?? this.status,
      results: results ?? this.results,
      albumResults: albumResults ?? this.albumResults,
    );
  }

  @override
  List<Object?> get props => [query, status, results, albumResults];
}
