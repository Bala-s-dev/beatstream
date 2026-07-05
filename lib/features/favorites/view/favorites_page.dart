//favorites
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../data/models/song.dart';
import '../../../data/repositories/music_repository.dart';
import '../../now_playing/cubit/player_cubit.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavoritesCubit(musicRepository: context.read<MusicRepository>()),
      child: const _FavoritesView(),
    );
  }
}

class _FavoritesView extends StatelessWidget {
  const _FavoritesView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state.status == FavoritesStatus.loading && state.songs.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => context.read<FavoritesCubit>().loadFavorites(),
          child: CustomScrollView(
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
                      Text('Favorites', style: AppTextStyles.displayLg()),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '${state.songs.length} Tracks',
                        style: AppTextStyles.bodyMd(
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state.songs.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: _EmptyFavorites(),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.marginMobile,
                  ),
                  sliver: SliverList.builder(
                    itemCount: state.songs.length,
                    itemBuilder: (context, index) {
                      final Song song = state.songs[index];
                      return FavoriteSongTile(
                        key: ValueKey(song.id),
                        song: song,
                        onTap: () {
                          context
                            .read<PlayerCubit>()
                            .play(song, queue: state.songs);
                          context.push('/now-playing');
                        },
                        onUnfavorite: () =>
                            context.read<FavoritesCubit>().unfavorite(song.id),
                      );
                    },
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 140)),
            ],
          ),
        );
      },
    );
  }
}

/// A favorites row with a smooth slide + fade exit animation before the
/// item is actually removed from the underlying list. Tapping the row
/// plays the song (with the full favorites list as queue); tapping the
/// heart icon unfavorites it without triggering playback.
class FavoriteSongTile extends StatefulWidget {
  const FavoriteSongTile({
    super.key,
    required this.song,
    required this.onTap,
    required this.onUnfavorite,
  });

  final Song song;
  final VoidCallback onTap;
  final VoidCallback onUnfavorite;

  @override
  State<FavoriteSongTile> createState() => _FavoriteSongTileState();
}

class _FavoriteSongTileState extends State<FavoriteSongTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 260),
  );
  late final Animation<double> _opacity = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );
  late final Animation<Offset> _offset = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.15, 0),
  ).animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleUnfavorite() async {
    await _controller.forward();
    widget.onUnfavorite();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: ReverseAnimation(_opacity),
      child: SlideTransition(
        position: _offset,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: AppNetworkImage(
                      url: widget.song.imageUrl,
                      width: 56,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.song.title, style: AppTextStyles.bodyLg()),
                        Text(
                          widget.song.artist,
                          style: AppTextStyles.bodyMd(
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _handleUnfavorite,
                    icon: const Icon(
                      Icons.favorite_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.marginMobile),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: AppSpacing.xl),
          const Icon(
            Icons.heart_broken_rounded,
            size: 64,
            color: AppColors.outlineVariant,
          ),
          const SizedBox(height: AppSpacing.md),
          Text('No favorite songs yet.', style: AppTextStyles.headlineMd()),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Start adding your favorite tracks to build your collection.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMd(color: AppColors.secondary),
          ),
        ],
      ),
    );
  }
}
