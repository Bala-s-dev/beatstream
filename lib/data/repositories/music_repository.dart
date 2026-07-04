import '../models/album.dart';
import '../models/song.dart';

/// Abstract data source for all music content.
///
/// Swapping mock data for a real backend later is a matter of writing a new
/// class (e.g. `ApiMusicRepository`) that implements this same contract and
/// wiring it up in `main.dart` - no UI/Cubit code needs to change.
abstract class MusicRepository {
  Future<List<String>> getLanguages();

  Future<List<Song>> getTrendingSongs();

  Future<List<Album>> getPopularAlbums();

  Future<List<Artist>> getArtists();

  Future<List<Song>> getRecentlyPlayed();

  Future<List<Song>> getFavorites();

  Future<Song> toggleFavorite(String songId);

  /// Simple client-side search across titles/artists. In a real
  /// implementation this would likely hit a `/search` endpoint instead.
  Future<List<Song>> search(String query);
}
