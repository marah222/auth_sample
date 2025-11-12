import '../../domain/entities/password_complexity.dart';
import '../../domain/repository/signup_repository.dart';
import '../datasources/signup_remote_data_source.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpRemoteDataSource remoteDataSource;

  SignUpRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PasswordComplexityEntity> getPasswordComplexitySetting() async {
    return await remoteDataSource.getPasswordComplexitySetting();
  }

  @override
  Future<bool> isTenantAvailable({required String tenantName}) async {
    return await remoteDataSource.isTenantAvailable(tenantName: tenantName);
  }

  @override
  Future<void> registerTenant({
    required String tenantName,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    return await remoteDataSource.registerTenant(
      tenantName: tenantName,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
