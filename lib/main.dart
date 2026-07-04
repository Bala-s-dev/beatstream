import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/mock_auth_repository.dart';
import 'data/repositories/mock_music_repository.dart';
import 'data/repositories/music_repository.dart';
import 'data/repositories/user_repository.dart';
import 'package:beatstream/features/now_playing/cubit/player_cubit.dart';

void main() {
  runApp(const BeatStreamApp());
}

class BeatStreamApp extends StatelessWidget {
  const BeatStreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Swap these Mock* implementations for real API-backed ones once a
        // backend exists - every Cubit only depends on the abstract
        // interfaces below, so no feature code needs to change.
        RepositoryProvider<MusicRepository>(
          create: (_) => MockMusicRepository(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (_) => MockAuthRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => MockUserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // Global: shared by the mini-player (always visible) and the
          // full-screen Now Playing page.
          BlocProvider<PlayerCubit>(
            create: (context) =>
                PlayerCubit(musicRepository: context.read<MusicRepository>()),
          ),
        ],
        child: MaterialApp.router(
          title: 'BeatStream',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
