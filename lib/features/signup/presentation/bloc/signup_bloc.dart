import 'package:auth_sample/features/signup/presentation/bloc/signup_event.dart';
import 'package:auth_sample/features/signup/presentation/bloc/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_password_complexity.dart';
import '../../domain/usecases/is_tenant_available.dart';
import '../../domain/usecases/register_tenant.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final GetPasswordComplexityUseCase getPasswordComplexityUseCase;
  final IsTenantAvailableUseCase isTenantAvailableUseCase;
  final RegisterTenantUseCase registerTenantUseCase;

  SignUpBloc({
    required this.getPasswordComplexityUseCase,
    required this.isTenantAvailableUseCase,
    required this.registerTenantUseCase,
  }) : super(SignUpInitial()) {
    on<ContinueWithEmailPressed>(_onContinueWithEmailPressed);
    on<PasswordScreenLoaded>(_onPasswordScreenLoaded);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
  }

  void _onContinueWithEmailPressed(
    ContinueWithEmailPressed event,
    Emitter<SignUpState> emit,
  ) {
    emit(NavigateToPasswordScreen());
  }

  Future<void> _onPasswordScreenLoaded(
    PasswordScreenLoaded event,
    Emitter<SignUpState> emit,
  ) async {
    // Emit loading state
    emit(const PasswordEntryState(isLoading: true));
    try {
      final complexity = await getPasswordComplexityUseCase();

      emit(PasswordEntryState(complexity: complexity, isLoading: false));
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    final currentState = state as PasswordEntryState;

    final isEmailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(event.email);
    emit(currentState.copyWith(email: event.email, isEmailValid: isEmailValid));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    final currentState = state as PasswordEntryState;
    if (currentState.complexity == null) return;

    final complexity = currentState.complexity!;
    final password = event.password;

    final hasMinLength = password.length >= complexity.requiredLength;
    final hasUppercase =
        !complexity.requireUppercase || password.contains(RegExp(r'[A-Z]'));
    final hasLowercase =
        !complexity.requireLowercase || password.contains(RegExp(r'[a-z]'));
    final hasDigit =
        !complexity.requireDigit || password.contains(RegExp(r'[0-9]'));
    final hasNonAlphanumeric =
        !complexity.requireNonAlphanumeric ||
        password.contains(RegExp(r'[^A-Za-z0-9]'));

    final isPasswordValid =
        hasMinLength &&
        hasUppercase &&
        hasLowercase &&
        hasDigit &&
        hasNonAlphanumeric;

    emit(
      currentState.copyWith(
        password: password,
        isPasswordValid: isPasswordValid,
      ),
    );
  }
}
