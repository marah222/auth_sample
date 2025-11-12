import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/signup/data/datasources/signup_remote_data_source.dart';
import '../../features/signup/data/repository/signup_repository_impl.dart';
import '../../features/signup/domain/repository/signup_repository.dart';
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
}
