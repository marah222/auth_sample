import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/signup/data/datasources/signup_remote_data_source.dart';
import '../../features/signup/data/repository/signup_repository_impl.dart';
import '../../features/signup/domain/repository/signup_repository.dart';
import '../../features/signup/domain/usecases/get_password_complexity.dart';
import '../../features/signup/domain/usecases/is_tenant_available.dart';
import '../../features/signup/domain/usecases/register_tenant.dart';
import '../../features/signup/presentation/bloc/signup_bloc.dart';
import '../network/api_client.dart';

final sl = GetIt.instance;

void setupDependencies() {
  sl.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: 'https://api.workiom.club')),
  );
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<Dio>()));

  // Data Sources

  sl.registerLazySingleton<SignUpRemoteDataSource>(
    () => SignUpRemoteDataSourceImpl(sl<ApiClient>()),
  );

  // Repositories

  sl.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(remoteDataSource: sl<SignUpRemoteDataSource>()),
  );
  // Use Cases
  sl.registerLazySingleton(() => GetPasswordComplexityUseCase(sl()));
  sl.registerLazySingleton(() => IsTenantAvailableUseCase(sl()));
  sl.registerLazySingleton(() => RegisterTenantUseCase(sl()));

  // BLoCs

  sl.registerFactory(
        () => SignUpBloc(
      getPasswordComplexityUseCase: sl(),
      isTenantAvailableUseCase: sl(),
      registerTenantUseCase: sl(),
    ),
  );
}
