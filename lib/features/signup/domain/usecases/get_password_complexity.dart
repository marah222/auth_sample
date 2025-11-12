import '../entities/password_complexity.dart';
import '../repository/signup_repository.dart';

class GetPasswordComplexityUseCase {
  final SignUpRepository repository;

  GetPasswordComplexityUseCase(this.repository);

  Future<PasswordComplexityEntity> call() async {
    return await repository.getPasswordComplexitySetting();
  }
}
