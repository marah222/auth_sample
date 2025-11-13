import 'package:auth_sample/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_strings.dart';
import '../app_spacing.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              AppStrings.stayOrganizedWith,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
          ),
          SvgPicture.asset(AppIcons.logo),
        ],
      ),
    );
  }
}
