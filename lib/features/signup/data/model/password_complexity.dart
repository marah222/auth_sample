import '../../domain/entities/password_complexity.dart';

class PasswordComplexityModel extends PasswordComplexityEntity {
  const PasswordComplexityModel({
    required super.requireDigit,
    required super.requireLowercase,
    required super.requireUppercase,
    required super.requireNonAlphanumeric,
    required super.requiredLength,
  });

  factory PasswordComplexityModel.fromJson(Map<String, dynamic> json) {
    final setting = json['setting'] as Map<String, dynamic>;

    return PasswordComplexityModel(
      requireDigit: setting['requireDigit'] ?? false,
      requireLowercase: setting['requireLowercase'] ?? false,
      requireUppercase: setting['requireUppercase'] ?? false,
      requireNonAlphanumeric: setting['requireNonAlphanumeric'] ?? false,
      requiredLength: setting['requiredLength'] ?? 0,
    );
  }
}
