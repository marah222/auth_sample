import 'package:auth_sample/features/signup/presentation/bloc/signup_event.dart';
import 'package:auth_sample/features/signup/presentation/bloc/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../core/design_system/widgets/password_strength.dart';
import '../../domain/usecases/get_password_complexity.dart';
import '../../domain/usecases/is_tenant_available.dart';
import '../../domain/usecases/register_tenant.dart';

EventTransformer<E> debounceRestartable<E>(Duration duration) {
  return (events, mapper) {
    return restartable<E>().call(events.debounce(duration), mapper);
  };
}
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
    on<ProceedToCompanyDetails>(_onProceedToCompanyDetails);
    on<TenantNameChanged>(
      _onTenantNameChanged,
      transformer: debounceRestartable(const Duration(milliseconds: 500)),
    );
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<CreateWorkspacePressed>(_onCreateWorkspacePressed);

  }

  void _onContinueWithEmailPressed(ContinueWithEmailPressed event,
      Emitter<SignUpState> emit,) {
    emit(NavigateToPasswordScreen());
  }

  Future<void> _onPasswordScreenLoaded(PasswordScreenLoaded event,
      Emitter<SignUpState> emit,) async {

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
    final hasUppercase = !complexity.requireUppercase ||
        password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = !complexity.requireLowercase ||
        password.contains(RegExp(r'[a-z]'));
    final hasDigit = !complexity.requireDigit ||
        password.contains(RegExp(r'[0-9]'));
    final hasNonAlphanumeric = !complexity.requireNonAlphanumeric ||
        password.contains(RegExp(r'[^A-Za-z0-9]'));

    final isPasswordValid = hasMinLength && hasUppercase && hasLowercase &&
        hasDigit && hasNonAlphanumeric;

    PasswordStrength strength;
    if (password.isEmpty) {
      strength = PasswordStrength.initial;
    } else if (isPasswordValid) {
      strength = PasswordStrength.strong;
    } else {
      strength = PasswordStrength.noStrong;
    }

    emit(currentState.copyWith(
      password: password,
      isPasswordValid: isPasswordValid,
      hasMinLength: hasMinLength,
      hasUppercase: hasUppercase,
      hasLowercase: hasLowercase,
      hasDigit: hasDigit,
      hasNonAlphanumeric: hasNonAlphanumeric,
      strength: strength,
    ));
  }
  void _onProceedToCompanyDetails(ProceedToCompanyDetails event, Emitter<SignUpState> emit) {
    final currentState = state as PasswordEntryState;
    emit(CompanyEntryState(
      email: currentState.email,
      password: currentState.password,
    ));
  }

  Future<void> _onTenantNameChanged(
      TenantNameChanged event,
      Emitter<SignUpState> emit,
      ) async {
    final currentState = state as CompanyEntryState;
    final name = event.name;

    if (name.length < 3) {
      emit(currentState.copyWith(
          tenantName: name, tenantStatus: TenantAvailabilityStatus.invalid));
      return;
    }

    emit(currentState.copyWith(
        tenantName: name, tenantStatus: TenantAvailabilityStatus.checking));

    try {
      final isAvailable = await isTenantAvailableUseCase(tenantName: name);
      if ((state as CompanyEntryState).tenantName == name) {
        emit(currentState.copyWith(
          tenantStatus: isAvailable
              ? TenantAvailabilityStatus.available
              : TenantAvailabilityStatus.unavailable,
        ));
      }
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<SignUpState> emit) {
    final currentState = state as CompanyEntryState;
    emit(currentState.copyWith(
        firstName: event.name, isFirstNameValid: event.name.isNotEmpty));
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<SignUpState> emit) {
    final currentState = state as CompanyEntryState;
    emit(currentState.copyWith(
        lastName: event.name, isLastNameValid: event.name.isNotEmpty));
  }


  Future<void> _onCreateWorkspacePressed(CreateWorkspacePressed event, Emitter<SignUpState> emit) async {
    if (state is! CompanyEntryState) return;
    final currentState = state as CompanyEntryState;
    if (!currentState.isFormValid) return;

    emit(currentState.copyWith(isSubmitting: true));

    try {
      await registerTenantUseCase(
        tenantName: currentState.tenantName,
        email: currentState.email,
        password: currentState.password,
        firstName: currentState.firstName,
        lastName: currentState.lastName,
      );
      emit(RegistrationSuccess());
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }
}