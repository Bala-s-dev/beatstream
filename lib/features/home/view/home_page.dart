//HomePage
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/section_header.dart';
import '../../../data/models/album.dart';
import '../../../data/models/song.dart';
import '../../../data/repositories/music_repository.dart';
import '../../now_playing/cubit/player_cubit.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';


/// The Home tab body. Rendered inside the shared shell scaffold (which
/// supplies the persistent AppBar, mini-player, and bottom nav), so this
/// widget is *just* the scrollable content.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(musicRepository: context.read<MusicRepository>()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading && state.trendingSongs.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == HomeStatus.failure) {
          return _ErrorRetry(
            message: state.errorMessage ?? 'Something went wrong.',
            onRetry: () => context.read<HomeCubit>().refresh(),
          );
        }

        // Safe preview counts — never index past what's actually available.
        final int trendingPreviewCount =
            state.trendingSongs.length < 5 ? state.trendingSongs.length : 5;
        final int albumsPreviewCount =
            state.popularAlbums.length < 5 ? state.popularAlbums.length : 5;

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => context.read<HomeCubit>().refresh(),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: const EdgeInsets.only(bottom: 160),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.marginMobile,
                  AppSpacing.lg,
                  AppSpacing.marginMobile,
                  AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello, Dharun', style: AppTextStyles.displayLg()),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Discover something new today.',
                      style: AppTextStyles.bodyMd(color: AppColors.secondary),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.marginMobile,
                  ),
                  itemCount: state.languages.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final String language = state.languages[index];
                    final bool selected = language == state.selectedLanguage;
                    return _LanguageChip(
                      label: language,
                      selected: selected,
                      onTap: () =>
                          context.read<HomeCubit>().selectLanguage(language),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.marginMobile,
                ),
                child: SectionHeader(
                  title: 'Trending Songs',
                  actionLabel: 'See all',
                  onAction: () {
                    debugPrint(
                        'See all tapped, songs: ${state.trendingSongs.length}');
                    context.push('/see-all-songs', extra: {
                      'title': 'Trending Songs',
                      'songs': state.trendingSongs,
                    });
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 210,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.marginMobile,
                  ),
                  itemCount: trendingPreviewCount,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final Song song = state.trendingSongs[index];
                    return _TrendingCard(
                      song: song,
                      onTap: () => context
                          .read<PlayerCubit>()
                          .play(song, queue: state.trendingSongs),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.marginMobile,
                ),
                child: SectionHeader(
                  title: 'Popular Albums',
                  actionLabel: 'See all',
                  onAction: () => context.push(
                    '/see-all-albums',
                    extra: {
                      'title': 'Popular Albums',
                      'albums': state.popularAlbums,
                    },
                  )
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 210,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.marginMobile,
                  ),
                  itemCount: albumsPreviewCount,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final Album album = state.popularAlbums[index];
                    return _AlbumCard(
                      album: album,
                      onTap: () {
                        // TODO: navigate to album detail / play album
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.marginMobile,
                ),
                child: Text('Artists', style: AppTextStyles.headlineMd()),
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 105,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.marginMobile,
                  ),
                  itemCount: state.artists.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.lg),
                  itemBuilder: (context, index) {
                    final Artist artist = state.artists[index];
                    return Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.outlineVariant,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: AppNetworkImage(
                            url: artist.imageUrl,
                            icon: Icons.person_rounded,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(artist.name, style: AppTextStyles.labelSm()),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.marginMobile,
                ),
                child: Text(
                  'Recently Played',
                  style: AppTextStyles.headlineMd(),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.marginMobile,
                ),
                itemCount: state.recentlyPlayed.length,
                itemBuilder: (context, index) {
                  final Song song = state.recentlyPlayed[index];
                  return _RecentlyPlayedTile(
                    song: song,
                    onTap: () => context
                        .read<PlayerCubit>()
                        .play(song, queue: state.recentlyPlayed),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LanguageChip extends StatelessWidget {
  const _LanguageChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.primary : AppColors.surfaceContainer,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          child: Text(
            label,
            style: AppTextStyles.labelSm(
              color: selected ? AppColors.onPrimary : AppColors.secondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _TrendingCard extends StatelessWidget {
  const _TrendingCard({required this.song, required this.onTap});

  final Song song;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 160,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: AppNetworkImage(url: song.imageUrl, width: 160),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                song.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyLg(),
              ),
              Text(
                song.artist,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyMd(color: AppColors.secondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AlbumCard extends StatelessWidget {
  const _AlbumCard({required this.album, required this.onTap});

  final Album album;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 160,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: AppNetworkImage(
                    url: album.imageUrl,
                    icon: Icons.album_rounded,
                    width: 160,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                album.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyLg(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentlyPlayedTile extends StatelessWidget {
  const _RecentlyPlayedTile({required this.song, required this.onTap});

  final Song song;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.outlineVariant),
                ),
                clipBehavior: Clip.antiAlias,
                child: AppNetworkImage(url: song.imageUrl, width: 56),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(song.title, style: AppTextStyles.bodyLg()),
                    Text(
                      song.artist,
                      style: AppTextStyles.bodyMd(color: AppColors.secondary),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.play_circle_outline_rounded,
                color: AppColors.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              size: 48,
              color: AppColors.outline,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLg(color: AppColors.secondary),
            ),
            const SizedBox(height: AppSpacing.md),
            TextButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
