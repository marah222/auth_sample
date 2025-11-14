import 'package:flutter/material.dart';

import '../app_colors.dart';

enum PasswordStrength { initial, noStrong, strong }

extension PasswordStrengthExtension on PasswordStrength {
  Color get color {
    switch (this) {
      case PasswordStrength.strong:
        return AppColors.successGreen;
      case PasswordStrength.noStrong:
        return AppColors.warningYellow;
      case PasswordStrength.initial:
        return AppColors.disabled;
    }
  }

  String get text {
    switch (this) {
      case PasswordStrength.strong:
        return 'Strong Password';
      case PasswordStrength.noStrong:
        return 'Not enough strong';
      case PasswordStrength.initial:
        return '';
    }
  }

  double get progress {
    switch (this) {
      case PasswordStrength.strong:
        return 1.0;
      case PasswordStrength.noStrong:
        return 0.5;
      case PasswordStrength.initial:
        return 0.0;
    }
  }
}
