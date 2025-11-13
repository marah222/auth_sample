import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_icons.dart';
import '../../constants/app_strings.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownButton(
      items: [
        DropdownMenuItem(
          value: AppStrings.languageEnglish.toLowerCase(),
          child: Text(
            AppStrings.languageEnglish,
            style: theme.textTheme.titleSmall?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: theme.colorScheme.secondary,
            ),
          ),
        ),
        DropdownMenuItem(
          value: AppStrings.languageArabic.toLowerCase(),
          child: Text(
            AppStrings.languageArabic,
            style: theme.textTheme.titleSmall?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: theme.colorScheme.secondary,
            ),
          ),
        ),
      ],
      value: AppStrings.languageEnglish.toLowerCase(),
      onChanged: (value) {},
      underline: const SizedBox.shrink(),
      selectedItemBuilder: (context) {
        return [
          Row(
            spacing: 8,
            children: [
              SvgPicture.asset(AppIcons.language),
              Text(
                AppStrings.languageEnglish,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ];
      },
    );
  }
}
