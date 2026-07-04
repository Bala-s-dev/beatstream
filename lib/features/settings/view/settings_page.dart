import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_list_tile.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../data/repositories/user_repository.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';

const String _kSettingsAvatarUrl =
    'https://lh3.googleusercontent.com/aida-public/AB6AXuAyF5aFXFCE83zQTGvJlbUHXcH0eeVSHYnq1tG3fWZOI9x1PU5-uCTaBEP7Iq_lJEDXtRnE7fCVeI42-c8lJk8OWD-lTvLNaJk7hUq-Kh8ZQaGSBaGrqiipVWQnn86KpS_9lm6UYPzvJVqLc8QsdQq2eFdRQMe2c9EYUeAKlxrK_QT8Iq9m0f0TN4Iexf3ivBHzWJv3RVUwvQ-8SzsCiV31lBhKmzYtVwZLZTX99qkeuAAlqE_-yZmhjkmMsVL5CN0eZgpUvAkOAQ';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static void _comingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('This section is coming soon.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SettingsCubit(userRepository: context.read<UserRepository>()),
      child: Scaffold(
        backgroundColor: AppColors.surfaceContainerLowest,
        appBar: AppBar(
          title: const Text('Settings'),
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
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            final cubit = context.read<SettingsCubit>();
            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.marginMobile,
              ),
              children: [
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      clipBehavior: Clip.antiAlias,
                      child: const AppNetworkImage(
                        url: _kSettingsAvatarUrl,
                        icon: Icons.person_rounded,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Alex Rivera', style: AppTextStyles.headlineMd()),
                        Text(
                          'alex.rivera@beatstream.io',
                          style: AppTextStyles.bodyMd(
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                const Divider(),
                _SectionLabel('ACCOUNT'),
                AppListTile(
                  icon: Icons.person_outline_rounded,
                  title: 'Edit Profile',
                  filledIconBackground: false,
                  dense: true,
                  onTap: () => _comingSoon(context),
                ),
                AppListTile(
                  icon: Icons.shield_outlined,
                  title: 'Security & Privacy',
                  filledIconBackground: false,
                  dense: true,
                  onTap: () => context.push('/privacy-security'),
                ),
                _SectionLabel('PLAYBACK'),
                AppListTile(
                  icon: Icons.graphic_eq_rounded,
                  title: 'Audio Quality',
                  subtitle: 'High (320kbps)',
                  filledIconBackground: false,
                  dense: true,
                  onTap: () => _comingSoon(context),
                ),
                AppToggleTile(
                  icon: Icons.wifi_rounded,
                  title: 'Download via Wi-Fi only',
                  value: state.wifiOnlyDownloads,
                  onChanged: (_) => cubit.toggleWifiOnlyDownloads(),
                ),
                _SectionLabel('APP'),
                AppListTile(
                  icon: Icons.palette_outlined,
                  title: 'Theme',
                  subtitle: 'Light Mode',
                  filledIconBackground: false,
                  dense: true,
                  onTap: () => _comingSoon(context),
                ),
                AppListTile(
                  icon: Icons.language_rounded,
                  title: 'Language',
                  filledIconBackground: false,
                  dense: true,
                  onTap: () => _comingSoon(context),
                ),
                AppListTile(
                  icon: Icons.info_outline_rounded,
                  title: 'About BeatStream',
                  filledIconBackground: false,
                  dense: true,
                  onTap: () => _comingSoon(context),
                ),
                const SizedBox(height: AppSpacing.lg),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () => context.go('/welcome'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.outlineVariant),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Log Out',
                      style: AppTextStyles.bodyLg(color: AppColors.error),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Center(
                  child: Text(
                    'Version 2.4.0 (Build 892)',
                    style: AppTextStyles.labelSm(color: AppColors.outline),
                  ),
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

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Text(label, style: AppTextStyles.labelSm(color: AppColors.primary)),
    );
  }
}
