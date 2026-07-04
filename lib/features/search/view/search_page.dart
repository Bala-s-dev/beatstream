import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../data/models/song.dart';
import '../../../data/repositories/music_repository.dart';
import 'package:beatstream/features/now_playing/cubit/player_cubit.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchCubit(musicRepository: context.read<MusicRepository>()),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus so the keyboard is up the moment the search page opens.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: AppSpacing.marginMobile,
        title: Container(
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const SizedBox(width: AppSpacing.sm),
              const Icon(Icons.search_rounded, color: AppColors.outline),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onChanged: context.read<SearchCubit>().queryChanged,
                  style: AppTextStyles.bodyLg(),
                  decoration: const InputDecoration(
                    hintText: 'Search songs, artists...',
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).maybePop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          switch (state.status) {
            case SearchStatus.idle:
              return Center(
                child: Text(
                  'Search for songs or artists',
                  style: AppTextStyles.bodyLg(color: AppColors.secondary),
                ),
              );
            case SearchStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case SearchStatus.empty:
              return Center(
                child: Text(
                  'No results for "${state.query}"',
                  style: AppTextStyles.bodyLg(color: AppColors.secondary),
                ),
              );
            case SearchStatus.failure:
              return Center(
                child: Text(
                  'Something went wrong. Try again.',
                  style: AppTextStyles.bodyLg(color: AppColors.secondary),
                ),
              );
            case SearchStatus.success:
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.marginMobile,
                  vertical: AppSpacing.md,
                ),
                itemCount: state.results.length,
                itemBuilder: (context, index) {
                  final Song song = state.results[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: AppNetworkImage(url: song.imageUrl, width: 48),
                    ),
                    title: Text(song.title, style: AppTextStyles.bodyLg()),
                    subtitle: Text(
                      song.artist,
                      style: AppTextStyles.bodyMd(color: AppColors.secondary),
                    ),
                    onTap: () => context
                        .read<PlayerCubit>()
                        .play(song, queue: state.results),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
