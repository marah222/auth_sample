import '../repository/signup_repository.dart';

class RegisterTenantUseCase {
  final SignUpRepository repository;

  RegisterTenantUseCase(this.repository);

  Future<void> call({
    required String tenantName,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    return await repository.registerTenant(
      tenantName: tenantName,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
  }
}