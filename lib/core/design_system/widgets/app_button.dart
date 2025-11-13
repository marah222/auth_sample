import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_icons.dart';
import '../../constants/app_strings.dart';
import '../app_colors.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

enum AppButtonType { primary, secondary, disabled }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.leading,
    this.tailing,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final Widget? leading;
  final bool? tailing;
  final String? semanticLabel;

  bool get _isDisabled => type == AppButtonType.disabled || onPressed == null;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = switch (type) {
      AppButtonType.primary => AppColors.primaryBlue,
      AppButtonType.secondary => AppColors.lightGreyBackground,
      AppButtonType.disabled => AppColors.disabled,
    };
    final foregroundColor = switch (type) {
      AppButtonType.primary => Colors.white,
      AppButtonType.secondary => AppColors.primaryDarkText,
      AppButtonType.disabled => AppColors.secondaryText,
    };
    return Semantics(
      button: true,
      enabled: !_isDisabled,
      label: semanticLabel ?? label,
      child: ElevatedButton(
        onPressed: _isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
          side: BorderSide.none,
          elevation: 0,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leading != null) ...[
                  leading!,
                  const SizedBox(width: AppSpacing.sm),
                ],
                Text(
                  label,
                  style: AppTypography.textTheme.labelLarge?.copyWith(
                    color: foregroundColor,
                  ),
                ),
              ],
            ),
            if (tailing != null)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: SvgPicture.asset(AppIcons.enterIcon),
                ),
              ),
          ],
        ),
      ),
    );

    return Semantics(
      button: true,
      enabled: !_isDisabled,
      label: semanticLabel ?? label,
      child: ElevatedButton(
        onPressed: _isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
          side: BorderSide.none,
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: AppSpacing.sm),
            ],
            Text(
              label,
              style: AppTypography.textTheme.labelLarge?.copyWith(
                color: foregroundColor,
              ),
            ),
            if (tailing != null) ...[SvgPicture.asset(AppIcons.enterIcon)],
          ],
        ),
      ),
    );
  }

  factory AppButton.google({Key? key, required VoidCallback? onPressed}) {
    return AppButton(
      key: key,
      label: AppStrings.continueWithGoogle,
      onPressed: onPressed,
      type: AppButtonType.secondary,
      leading: SvgPicture.asset(AppIcons.google),
      semanticLabel: AppStrings.googleButtonAriaLabel,
    );
  }

  factory AppButton.email({Key? key, required VoidCallback? onPressed}) {
    return AppButton(
      key: key,
      label: AppStrings.continueWithEmail,
      onPressed: onPressed,
      tailing: true,
      semanticLabel: AppStrings.emailButtonAriaLabel,
    );
  }
}
