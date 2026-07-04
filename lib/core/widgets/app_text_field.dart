import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// A labeled input with hover and focus states.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.errorText,
    this.onChanged,
    this.trailing,
    this.autofillHints,
    this.inputFormatters,
    this.uppercaseLabel = true,
    this.onSubmitted,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final Widget? trailing;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final bool uppercaseLabel;
  final ValueChanged<String>? onSubmitted;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final FocusNode _focusNode;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasError =
        widget.errorText != null && widget.errorText!.isNotEmpty;

    final bool isFocused = _focusNode.hasFocus;

    final Color borderColor = hasError
        ? AppColors.error
        : (isFocused || _isHovered)
            ? AppColors.primary
            : AppColors.outlineVariant;

    final double borderWidth = (isFocused || hasError) ? 2 : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.xs,
              bottom: 4,
            ),
            child: Text(
              widget.uppercaseLabel ? widget.label.toUpperCase() : widget.label,
              style: AppTextStyles.labelSm(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
        MouseRegion(
          cursor: SystemMouseCursors.text,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: borderColor,
                width: borderWidth,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: AppSpacing.md),
                if (widget.prefixIcon != null)
                  Icon(
                    widget.prefixIcon,
                    color: isFocused ? AppColors.primary : AppColors.outline,
                    size: 22,
                  ),
                if (widget.prefixIcon != null)
                  const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    focusNode: _focusNode,
                    obscureText: widget.obscureText,
                    keyboardType: widget.keyboardType,
                    textInputAction: widget.textInputAction,
                    onChanged: widget.onChanged,
                    onSubmitted: widget.onSubmitted,
                    autofillHints: widget.autofillHints,
                    inputFormatters: widget.inputFormatters,
                    cursorColor: AppColors.primary,
                    style: AppTextStyles.bodyLg(),
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: AppTextStyles.bodyLg(
                        color: AppColors.outline,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                if (widget.trailing != null) widget.trailing!,
                const SizedBox(width: AppSpacing.md),
              ],
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          child: hasError
              ? Padding(
                  key: ValueKey(widget.errorText),
                  padding: const EdgeInsets.only(
                    top: 6,
                    left: AppSpacing.xs,
                  ),
                  child: Text(
                    widget.errorText!,
                    style: AppTextStyles.bodyMd(
                      color: AppColors.error,
                    ).copyWith(fontSize: 12),
                  ),
                )
              : const SizedBox(
                  key: ValueKey('no-error'),
                  height: 0,
                ),
        ),
      ],
    );
  }
}
