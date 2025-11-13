import 'package:equatable/equatable.dart';

import '../../domain/entities/password_complexity.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => []; }


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

  const PasswordEntryState({
    this.complexity,
    this.email = '',
    this.password = '',
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isLoading = false,
  });

  PasswordEntryState copyWith({
    PasswordComplexityEntity? complexity,
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isLoading,
  }) {
    return PasswordEntryState(
      complexity: complexity ?? this.complexity,
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool get isFormValid => isEmailValid && isPasswordValid;
  @override
  List<Object?> get props => [
    ...super.props,
    complexity,
    email,
    password,
    isEmailValid,
    isPasswordValid,
    isLoading,
  ];
}