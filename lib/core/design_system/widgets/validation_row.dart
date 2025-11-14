import 'package:flutter/material.dart';

import '../app_colors.dart';

class ValidationRow extends StatelessWidget {
  final String text;
  final bool isValid;

  const ValidationRow({super.key, required this.text, required this.isValid});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? AppColors.successGreen : AppColors.errorRed,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.secondaryText),
        ),
      ],
    );
  }
}
