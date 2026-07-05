import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../data/models/album.dart';
import '../../../data/models/song.dart';
import '../../now_playing/cubit/player_cubit.dart';

/// Displays every track inside a single album, with an artwork header.
/// Reuses the same tile/play behavior as SeeAllSongsPage — tapping a
/// track plays it with the rest of the album as the queue.
class AlbumDetailPage extends StatelessWidget {
  const AlbumDetailPage({super.key, required this.album});

  final Album album;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.marginMobile,
                AppSpacing.xl,
                AppSpacing.marginMobile,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                      ),
                      const Text(
                        'BeatStream',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.outlineVariant),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: AppNetworkImage(
                          url: album.imageUrl,
                          icon: Icons.album_rounded,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Center(
                    child: Text(
                      album.title,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.displayLg(),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Center(
                    child: Text(
                      '${album.songs.length} Tracks',
                      style: AppTextStyles.bodyMd(color: AppColors.secondary),
                    ),
                  ),
                  if (album.songs.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.lg),
                    Center(
                      child: FilledButton.icon(
                        onPressed: () {
                          context.read<PlayerCubit>().play(
                                album.songs.first,
                                queue: album.songs,
                              );
                          context.push('/now-playing');
                        },
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: const Text('Play All'),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (album.songs.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: _EmptyAlbumSongs(),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.marginMobile,
              ),
              sliver: SliverList.builder(
                itemCount: album.songs.length,
                itemBuilder: (context, index) {
                  final Song song = album.songs[index];
                  return _AlbumSongTile(
                    song: song,
                    trackNumber: index + 1,
                    onTap: () {
                      context
                          .read<PlayerCubit>()
                          .play(song, queue: album.songs);
                      context.push('/now-playing');
                    },
                  );
                },
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 140)),
        ],
      ),
    );
  }
}

class _AlbumSongTile extends StatelessWidget {
  const _AlbumSongTile({
    required this.song,
    required this.trackNumber,
    required this.onTap,
  });

  final Song song;
  final int trackNumber;
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
              SizedBox(
                width: 28,
                child: Text(
                  '$trackNumber',
                  style: AppTextStyles.bodyMd(color: AppColors.secondary),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
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

class _EmptyAlbumSongs extends StatelessWidget {
  const _EmptyAlbumSongs();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.marginMobile),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: AppSpacing.xl),
          const Icon(
            Icons.music_off_rounded,
            size: 64,
            color: AppColors.outlineVariant,
          ),
          const SizedBox(height: AppSpacing.md),
          Text('No tracks in this album yet.',
              style: AppTextStyles.headlineMd()),
        ],
      ),
    );
  }
}
