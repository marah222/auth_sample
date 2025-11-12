import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/api_client.dart';

final sl = GetIt.instance;

void setupDependencies() {
  sl.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: 'https://api.workiom.club')),
  );
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<Dio>()));
}
