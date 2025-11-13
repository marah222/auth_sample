import 'package:flutter/material.dart';

import '../../constants/app_icons.dart';
import '../../constants/app_strings.dart';
import '../app_colors.dart';
import '../app_typography.dart';

class AppBackButtonBar extends StatelessWidget implements PreferredSizeWidget {
  const AppBackButtonBar({
    super.key,
    this.onBack,
    this.title,
  });

  final VoidCallback? onBack;
  final String? title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        tooltip: AppStrings.backButtonTooltip,
        icon: const Icon(AppIcons.arrowBack, color: AppColors.primaryDarkText),
        onPressed: onBack ?? () => Navigator.of(context).maybePop(),
      ),
      title: title != null
          ? Text(
              title!,
              style: AppTypography.textTheme.headlineSmall,
            )
          : null,
      centerTitle: false,
    );
  }
}

