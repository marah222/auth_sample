import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../app_typography.dart';

class AppBackButtonBar extends StatelessWidget implements PreferredSizeWidget {
  const AppBackButtonBar({super.key, this.onBack, this.title});

  final VoidCallback? onBack;
  final String? title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 24,
          color: AppColors.primaryBlue,
        ),
        onPressed: onBack ?? () => Navigator.of(context).maybePop(),
      ),
      title: title != null
          ? Text(
              title!,
              style: AppTypography.textTheme.bodySmall?.copyWith(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            )
          : null,
      centerTitle: false,
    );
  }
}
