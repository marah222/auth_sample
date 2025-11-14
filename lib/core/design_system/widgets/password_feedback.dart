import 'package:auth_sample/core/design_system/widgets/password_strength.dart';
import 'package:auth_sample/core/design_system/widgets/validation_row.dart';
import 'package:flutter/material.dart';

import '../../../features/signup/domain/entities/password_complexity.dart';
import '../app_colors.dart';

class PasswordFeedback extends StatelessWidget {
  final PasswordComplexityEntity complexity;
  final String password;
  final PasswordStrength strength;
  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasLowercase;

  const PasswordFeedback({
    super.key,
    required this.complexity,
    required this.password,
    required this.strength,
    required this.hasMinLength,
    required this.hasUppercase,
    required this.hasLowercase,
  });

  @override
  Widget build(BuildContext context) {

    final hasMinLength = password.length >= complexity.requiredLength;
    final hasUppercase = !complexity.requireUppercase || password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = !complexity.requireLowercase || password.contains(RegExp(r'[a-z]'));
    final hasDigit = !complexity.requireDigit || password.contains(RegExp(r'[0-9]'));
    if (strength == PasswordStrength.initial) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
            password.isEmpty ? 'Not enough strong' : 'Strong password',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: strength.progress,
            backgroundColor: AppColors.lightGreyBackground,
            color: strength.color,
            minHeight: 6,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(
              strength == PasswordStrength.strong
                  ? Icons.check_circle
                  : Icons.warning_amber_rounded,
              color: strength.color,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              strength.text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryDarkText),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ValidationRow(
          text: 'Passwords must have at least ${complexity.requiredLength} characters',
          isValid: hasMinLength,
        ),
        if (complexity.requireUppercase) ...[
          const SizedBox(height: 8),
          ValidationRow(
            text: "Passwords must have at least one uppercase ('A'-'Z').",
            isValid: hasUppercase,
          ),
        ],
        if (complexity.requireLowercase) ...[
          const SizedBox(height: 8),
          ValidationRow(
            text: "Passwords must have at least one lowercase ('a'-'z').",
            isValid: hasLowercase,
          ),
        ],
        if (complexity.requireDigit) ...[
          const SizedBox(height: 8),
          ValidationRow(
            text: 'Passwords must have at least one digit (0-9).',
            isValid: hasDigit,
          ),
        ],
      ],
    );
  }
}