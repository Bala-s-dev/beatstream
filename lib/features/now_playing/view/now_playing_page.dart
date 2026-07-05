import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beatstream/core/theme/app_colors.dart';
import 'package:beatstream/core/theme/app_spacing.dart';
import 'package:beatstream/core/theme/app_text_styles.dart';
import 'package:beatstream/core/widgets/app_network_image.dart';
import 'package:beatstream/features/now_playing/cubit/player_cubit.dart';
import 'package:beatstream/features/now_playing/cubit/player_state.dart';

class NowPlayingPage extends StatelessWidget {
  const NowPlayingPage({super.key});

  String _formatDuration(int totalSeconds) {
    final int minutes = totalSeconds ~/ 60;
    final int seconds = totalSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          color: AppColors.onSurfaceVariant,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('BeatStream'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            color: AppColors.onSurfaceVariant,
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<PlayerCubit, PlayerState>(
        builder: (context, state) {
          if (!state.hasTrack) {
            return Center(
              child: Text(
                'Nothing is playing right now.',
                style: AppTextStyles.bodyLg(color: AppColors.secondary),
              ),
            );
          }

          final song = state.currentSong!;
          final cubit = context.read<PlayerCubit>();

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.marginMobile,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: AppNetworkImage(url: song.imageUrl),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  song.title,
                                  style: AppTextStyles.headlineMd(),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  song.artist,
                                  style: AppTextStyles.bodyLg(
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: cubit.toggleFavoriteCurrent,
                            icon: Icon(
                              song.isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              color: song.isFavorite
                                  ? AppColors.primary
                                  : AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      _SeekBar(
                        progress: state.progress,
                        onChanged: cubit.seekTo,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(state.positionSeconds),
                            style: AppTextStyles.labelSm(
                              color: AppColors.outline,
                            ),
                          ),
                          Text(
                            _formatDuration(state.durationSeconds),
                            style: AppTextStyles.labelSm(
                              color: AppColors.outline,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            iconSize: 32,
                            onPressed: cubit.skipPrevious,
                            icon: const Icon(
                              Icons.skip_previous_rounded,
                              color: AppColors.onSurface,
                            ),
                          ),
                          Material(
                            color: AppColors.primaryContainer,
                            shape: const CircleBorder(),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: cubit.togglePlayPause,
                              child: SizedBox(
                                width: 80,
                                height: 80,
                                child: Icon(
                                  state.isPlaying
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  color: AppColors.onPrimaryContainer,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            iconSize: 32,
                            onPressed: cubit.skipNext,
                            icon: const Icon(
                              Icons.skip_next_rounded,
                              color: AppColors.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SeekBar extends StatelessWidget {
  const _SeekBar({required this.progress, required this.onChanged});

  final double progress;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 4,
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.surfaceContainerHigh,
        thumbColor: Colors.white,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 8,
          elevation: 0,
        ),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
      ),
      child: Slider(
        value: progress.clamp(0, 1),
        onChanged: onChanged,
      ),
    );
  }
}
