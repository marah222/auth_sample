import '../repository/signup_repository.dart';

class IsTenantAvailableUseCase {
  final SignUpRepository repository;

  IsTenantAvailableUseCase(this.repository);

  Future<bool> call({required String tenantName}) async {
    if (tenantName.isEmpty) {
      return false;
    }
    return await repository.isTenantAvailable(tenantName: tenantName);
  }
}
