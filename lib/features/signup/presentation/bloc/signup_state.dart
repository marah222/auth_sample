import 'package:equatable/equatable.dart';

import '../../../../core/design_system/widgets/password_strength.dart';
import '../../domain/entities/password_complexity.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class NavigateToPasswordScreen extends SignUpState {}

class SignUpError extends SignUpState {
  final String message;

  const SignUpError(this.message);

  @override
  List<Object> get props => [message];
}

class PasswordEntryState extends SignUpState {
  final PasswordComplexityEntity? complexity;
  final String email;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isLoading;

  // Password rule checks
  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasDigit;
  final bool hasNonAlphanumeric;

  final PasswordStrength strength;

  const PasswordEntryState({
    this.complexity,
    this.email = '',
    this.password = '',
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isLoading = false,
    this.hasMinLength = false,
    this.hasUppercase = false,
    this.hasLowercase = false,
    this.hasDigit = false,
    this.hasNonAlphanumeric = false,
    this.strength = PasswordStrength.initial,
  });

  /// Copy state with updated fields
  PasswordEntryState copyWith({
    PasswordComplexityEntity? complexity,
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isLoading,
    bool? hasMinLength,
    bool? hasUppercase,
    bool? hasLowercase,
    bool? hasDigit,
    bool? hasNonAlphanumeric,
    PasswordStrength? strength,
  }) {
    return PasswordEntryState(
      complexity: complexity ?? this.complexity,
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isLoading: isLoading ?? this.isLoading,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasUppercase: hasUppercase ?? this.hasUppercase,
      hasLowercase: hasLowercase ?? this.hasLowercase,
      hasDigit: hasDigit ?? this.hasDigit,
      hasNonAlphanumeric: hasNonAlphanumeric ?? this.hasNonAlphanumeric,
      strength: strength ?? this.strength,
    );
  }

  /// Returns true when both email and password are valid
  bool get isFormValid => isEmailValid && isPasswordValid;

  @override
  List<Object?> get props => [
    complexity,
    email,
    password,
    isEmailValid,
    isPasswordValid,
    isLoading,
    hasMinLength,
    hasUppercase,
    hasLowercase,
    hasDigit,
    hasNonAlphanumeric,
    strength,
  ];
}

class NavigateToCompanyScreen extends SignUpState {}

enum TenantAvailabilityStatus { initial, checking, available, unavailable, invalid }

class CompanyEntryState extends SignUpState {
  final String email;
  final String password;
  final String tenantName;
  final String firstName;
  final String lastName;
  final TenantAvailabilityStatus tenantStatus;
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isSubmitting;

  const CompanyEntryState({
    required this.email,
    required this.password,
    this.tenantName = '',
    this.firstName = '',
    this.lastName = '',
    this.tenantStatus = TenantAvailabilityStatus.initial,
    this.isFirstNameValid = false,
    this.isLastNameValid = false,
    this.isSubmitting = false,
  });

  bool get isFormValid =>
      tenantStatus == TenantAvailabilityStatus.available &&
          isFirstNameValid &&
          isLastNameValid &&
          !isSubmitting;

  CompanyEntryState copyWith({
    String? tenantName,
    String? firstName,
    String? lastName,
    TenantAvailabilityStatus? tenantStatus,
    bool? isFirstNameValid,
    bool? isLastNameValid,
    bool? isSubmitting,
  }) {
    return CompanyEntryState(
      email: this.email,
      password: this.password,
      tenantName: tenantName ?? this.tenantName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      tenantStatus: tenantStatus ?? this.tenantStatus,
      isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object> get props => [
    email,
    password,
    tenantName,
    firstName,
    lastName,
    tenantStatus,
    isFirstNameValid,
    isLastNameValid,
    isSubmitting,
  ];
}
class RegistrationSuccess extends SignUpState {}