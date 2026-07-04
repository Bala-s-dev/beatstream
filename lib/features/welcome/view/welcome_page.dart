import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_buttons.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceContainerLowest,
      body: SafeArea(
        child: Column(
          children: [
            // Logo
            Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.md,
                bottom: AppSpacing.md,
              ),
              child: Text(
                'BeatStream',
                style: AppTextStyles.displayLg(),
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.marginMobile,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 280,
                          height: 280,
                          child: Lottie.asset(
                            'assets/animations/music_ani.json',
                            repeat: true,
                            animate: true,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        Text(
                          'Your Music,\nSimply Streamed',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.displayLg(),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'The quietest, most focused way to experience your favorite artists.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyLg(
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        PrimaryButton(
                          label: 'Login',
                          onPressed: () => context.push('/login'),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        SecondaryButton(
                          label: 'Register',
                          onPressed: () => context.push('/register'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
