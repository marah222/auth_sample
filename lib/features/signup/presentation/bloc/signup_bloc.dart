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
  }

  void _onContinueWithEmailPressed(
    ContinueWithEmailPressed event,
    Emitter<SignUpState> emit,
  ) {
    emit(NavigateToPasswordScreen());
  }
}
