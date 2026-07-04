import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart' show AppRadius;
import '../theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.height = 56,
    this.radius = AppRadius.xl,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final bool disabled = onPressed == null || isLoading;
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Material(
        color: disabled
            ? AppColors.onSurface.withValues(alpha: 0.4)
            : AppColors.onSurface,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: disabled ? null : onPressed,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.surface,
                      ),
                    ),
                  )
                : Text(
                    label,
                    style: AppTextStyles.headlineMd(color: AppColors.surface),
                  ),
          ),
        ),
      ),
    );
  }
}

/// Ghost-style button with a 1px outline border - secondary CTA style.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 56,
    this.radius = AppRadius.xl,
    this.foregroundColor = AppColors.onSurface,
  });

  final String label;
  final VoidCallback? onPressed;
  final double height;
  final double radius;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.surfaceVariant),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          backgroundColor: Colors.transparent,
        ).copyWith(
          overlayColor: WidgetStatePropertyAll(
            AppColors.surfaceContainerLow.withValues(alpha: 0.6),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.headlineMd(color: foregroundColor),
        ),
      ),
    );
  }
}
