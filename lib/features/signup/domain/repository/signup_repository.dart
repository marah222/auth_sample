import '../entities/password_complexity.dart';

abstract class SignUpRepository {
  Future<PasswordComplexityEntity> getPasswordComplexitySetting();

  Future<bool> isTenantAvailable({required String tenantName});

  Future<void> registerTenant({
    required String tenantName,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
}
