import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_list_tile.dart';
import '../../../data/repositories/user_repository.dart';
import '../cubit/privacy_cubit.dart';
import '../cubit/privacy_state.dart';

class PrivacySecurityPage extends StatelessWidget {
  const PrivacySecurityPage({super.key});

  static void _comingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('This section is coming soon.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PrivacyCubit(userRepository: context.read<UserRepository>()),
      child: Scaffold(
        backgroundColor: AppColors.surfaceContainerLowest,
        appBar: AppBar(
          title: const Text('Privacy & Security'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary),
            onPressed: () => context.pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert_rounded, color: AppColors.primary),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<PrivacyCubit, PrivacyState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final cubit = context.read<PrivacyCubit>();
            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.marginMobile,
                vertical: AppSpacing.lg,
              ),
              children: [
                Text('Privacy', style: AppTextStyles.displayLg()),
                const SizedBox(height: 4),
                Text(
                  'Manage how your listening activity is shared with '
                  'others.',
                  style: AppTextStyles.bodyMd(color: AppColors.secondary),
                ),
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Private Session',
                              style: AppTextStyles.bodyLg(),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Hide your current activity from your '
                              'followers.',
                              style: AppTextStyles.bodyMd(
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: state.privateSession,
                        onChanged: (_) => cubit.togglePrivateSession(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                AppListTile(
                  icon: Icons.playlist_play_rounded,
                  title: 'Public Playlists',
                  subtitle: 'Control which playlists are visible on your '
                      'profile.',
                  filledIconBackground: false,
                  dense: true,
                  onTap: () => _comingSoon(context),
                ),
                AppListTile(
                  icon: Icons.history_rounded,
                  title: 'Listening History',
                  subtitle:
                      'Manage your personalized recommendations.',
                  filledIconBackground: false,
                  dense: true,
                  onTap: () => _comingSoon(context),
                ),
                const SizedBox(height: AppSpacing.lg),
                const Divider(),
                const SizedBox(height: AppSpacing.lg),
                Text('Security', style: AppTextStyles.displayLg()),
                const SizedBox(height: 4),
                Text(
                  'Keep your account safe and manage access permissions.',
                  style: AppTextStyles.bodyMd(color: AppColors.secondary),
                ),
                const SizedBox(height: AppSpacing.md),
                AppListTile(
                  icon: Icons.lock_outline_rounded,
                  filledIconBackground: false,
                  dense: true,
                  title: 'Change Password',
                  subtitle: 'Update your login credentials.',
                  onTap: () => _comingSoon(context),
                ),
                AppListTile(
                  icon: Icons.verified_user_outlined,
                  filledIconBackground: false,
                  dense: true,
                  title: 'Two-Factor Authentication',
                  subtitle: 'Add an extra layer of protection.',
                  onTap: () => _comingSoon(context),

                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            );
          },
        ),
      ),
    );
  }
}
