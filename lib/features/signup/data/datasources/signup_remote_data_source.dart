import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../model/password_complexity.dart';

abstract class SignUpRemoteDataSource {
  Future<PasswordComplexityModel> getPasswordComplexitySetting();
  Future<bool> isTenantAvailable({required String tenantName});
  Future<void> registerTenant({
    required String tenantName,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
}

// Concrete implementation of the data source.
class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  final ApiClient _apiClient;

  SignUpRemoteDataSourceImpl(this._apiClient);

  @override
  Future<PasswordComplexityModel> getPasswordComplexitySetting() async {
    try {
      final response = await _apiClient.get('/api/services/app/Profile/GetPasswordComplexitySetting');
      return PasswordComplexityModel.fromJson(response.data['result']);
    } on DioException catch (e) {
      throw Exception('Failed to fetch password complexity: ${e.message}');
    }
  }

  @override
  Future<bool> isTenantAvailable({required String tenantName}) async {
    try {
      final response = await _apiClient.post(
        '/api/services/app/Account/IsTenantAvailable',
        data: {'tenancyName': tenantName},
      );
     return response.data['result']['state'] == 1;
    } on DioException catch (e) {
      throw Exception('Failed to check tenant availability: ${e.message}');
    }
  }

  @override
  Future<void> registerTenant({
    required String tenantName,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final payload = {
        'tenancyName': tenantName,
        'emailAddress': email,
        'password': password,
        'name': firstName,
        'adminFirstName': firstName,
        'adminLastName': lastName,
        'adminEmailAddress': email,
        'adminPassword': password,
        'editionId': 1,
        'subscriptionStartType': 1,
      };
      await _apiClient.post('/api/services/app/TenantRegistration/RegisterTenant', data: payload);
    } on DioException catch (e) {
      throw Exception('Failed to register tenant: ${e.message}');
    }
  }
}