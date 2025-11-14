import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class ContinueWithEmailPressed extends SignUpEvent {}

class ContinueWithGooglePressed extends SignUpEvent {}

class PasswordScreenLoaded extends SignUpEvent {}

class EmailChanged extends SignUpEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends SignUpEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class ProceedToCompanyDetails extends SignUpEvent {}

class TenantNameChanged extends SignUpEvent {
  final String name;
  const TenantNameChanged(this.name);
  @override
  List<Object> get props => [name];
}

class FirstNameChanged extends SignUpEvent {
  final String name;
  const FirstNameChanged(this.name);
  @override
  List<Object> get props => [name];
}

class LastNameChanged extends SignUpEvent {
  final String name;
  const LastNameChanged(this.name);
  @override
  List<Object> get props => [name];
}

class CreateWorkspacePressed extends SignUpEvent {}