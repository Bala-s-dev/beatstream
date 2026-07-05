import 'package:beatstream/features/home/album-screen/album_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/view/login_page.dart';
import '../../features/auth/view/register_page.dart';
import '../../features/favorites/view/favorites_page.dart';
import '../../features/home/view/home_page.dart';
import '../../features/notifications/view/notifications_page.dart';
import '../../features/now_playing/view/now_playing_page.dart';
import '../../features/privacy_security/view/privacy_security_page.dart';
import '../../features/profile/view/profile_page.dart';
import '../../features/search/view/search_page.dart';
import '../../features/settings/view/settings_page.dart';
import '../../features/shell/app_shell.dart';
import '../../features/welcome/view/welcome_page.dart';
import '../../features/home/trending-song-screen/see_all_songs_page.dart';
import '../../data/models/song.dart';
import '../../features/home/album-screen/see_all_albums_page.dart';
import '../../data/models/album.dart';

abstract final class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/welcome',
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      // Screens pushed above the shell (no bottom nav).
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: '/privacy-security',
        builder: (context, state) => const PrivacySecurityPage(),
      ),
      GoRoute(
        path: '/now-playing',
        builder: (context, state) => const NowPlayingPage(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchPage(),
      ),
      // Single, top-level album-detail route. Reachable from Home, See All
      // Albums, AND Search (which lives outside the shell) — so it must be
      // top-level rather than nested under /home, matching /now-playing.
      GoRoute(
        path: '/album-detail',
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! Album) {
            return const Scaffold(
              body: Center(child: Text('No album data received')),
            );
          }
          return AlbumDetailPage(album: extra);
        },
      ),

      // Bottom-nav shell: Home / Favorites / Profile.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomePage(),
                routes: [
                  // Nested under /home so AppShell (and the mini-player)
                  // stays mounted while viewing these pages. These are only
                  // ever reached FROM Home, so nesting is safe here.
                  GoRoute(
                    path: 'see-all-songs',
                    builder: (context, state) {
                      final extra = state.extra;
                      if (extra is! Map) {
                        return Scaffold(
                          body: Center(
                            child: Text('No data received (extra: $extra)'),
                          ),
                        );
                      }
                      final songs = (extra['songs'] as List).cast<Song>();
                      return SeeAllSongsPage(
                        title: extra['title'] as String,
                        songs: songs,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'see-all-albums',
                    builder: (context, state) {
                      final extra = state.extra;
                      if (extra is! Map) {
                        return Scaffold(
                          body: Center(
                            child: Text('No data received (extra: $extra)'),
                          ),
                        );
                      }
                      final albums = (extra['albums'] as List).cast<Album>();
                      return SeeAllAlbumsPage(
                        title: extra['title'] as String,
                        albums: albums,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                builder: (context, state) => const FavoritesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Route not found: ${state.uri}')),
    ),
  );
}
