import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:beatstream/core/theme/app_colors.dart';
import 'package:beatstream/core/theme/app_spacing.dart';
import 'package:beatstream/core/theme/app_text_styles.dart';
import 'package:beatstream/core/widgets/app_network_image.dart';
import 'package:beatstream/features/now_playing/cubit/player_cubit.dart';
import 'package:beatstream/features/now_playing/cubit/player_state.dart';

/// "Now Playing: <track>" bar with a progress line and play/pause button,
/// pinned above the bottom nav bar - matches the mini-player on the Home
/// screen in the source design, but shown globally so playback state is
/// always visible & controllable.
class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerCubit, PlayerState>(
      buildWhen: (previous, current) =>
          previous.currentSong != current.currentSong ||
          previous.isPlaying != current.isPlaying ||
          previous.positionSeconds != current.positionSeconds,
      builder: (context, state) {
        if (!state.hasTrack) return const SizedBox.shrink();
        final song = state.currentSong!;
        final cubit = context.read<PlayerCubit>();

        return Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.marginMobile,
            0,
            AppSpacing.marginMobile,
            AppSpacing.sm,
          ),
          child: Material(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => context.push('/now-playing'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.outlineVariant),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AppNetworkImage(
                        url: song.imageUrl,
                        width: 36,
                        height: 36,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Playing: ${song.title}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodyMd(),
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: state.progress.clamp(0, 1),
                              minHeight: 3,
                              backgroundColor:
                                  AppColors.surfaceContainerHighest,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed:
                          state.queue.length > 1 ? cubit.skipPrevious : null,
                      icon: Icon(
                        Icons.skip_previous_rounded,
                        color: state.queue.length > 1
                            ? AppColors.primary
                            : AppColors.outlineVariant,
                      ),
                    ),
                    IconButton(
                      onPressed: cubit.togglePlayPause,
                      icon: Icon(
                        state.isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: state.queue.length > 1 ? cubit.skipNext : null,
                      icon: Icon(
                        Icons.skip_next_rounded,
                        color: state.queue.length > 1
                            ? AppColors.primary
                            : AppColors.outlineVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
