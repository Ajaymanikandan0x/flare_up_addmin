import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio/browser.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_service.dart';
import '../models/host_model_signup.dart';
import '../models/host_model_signin.dart';

import '../../../../core/utils/logger.dart';

class AdminRemoteDatasource {
  final NetworkService _networkService;
  final Dio dio;

  AdminRemoteDatasource(this._networkService) : dio = _networkService.dio {
    dio.options.headers['Content-Type'] = 'application/json';

    if (kIsWeb) {
      // Web-specific configuration
      (dio.httpClientAdapter as BrowserHttpClientAdapter).withCredentials = true;
    } else {
      // IO platforms configuration (Android, iOS, desktop)
      if (!const bool.fromEnvironment('dart.vm.product')) {
        // Development-only certificate handling
        (dio.httpClientAdapter as IOHttpClientAdapter).validateCertificate =
            (cert, host, port) => true;
      } else {
        // Production certificate handling
        (dio.httpClientAdapter as IOHttpClientAdapter).validateCertificate =
            (cert, host, port) {
          final isValidHost = cert?.subject.contains(host) ?? false;
          final isValidIssuer =
              cert?.issuer.contains("YourExpectedIssuer") ?? false;
          final isNotExpired = cert?.endValidity.isAfter(DateTime.now()) ?? false;
          return isValidHost && isValidIssuer && isNotExpired;
        };
      }
    }
  }

  Future<ApiResponse<AdminModelSignIn>> login({
    required String username,
    required String password,
  }) async {
    Logger.debug('Attempting login for host: $username');

    return _networkService.safeApiCall(
      apiCall: () => dio.post(
        ApiEndpoints.baseUrl + ApiEndpoints.login,
        data: {
          'username': username,
          'password': password,
        },
      ),
      transform: (data) => AdminModelSignIn.fromJson(data),
    );
  }

  Future<ApiResponse<AdminModelSignup>> signUp({
    required String username,
    required String fullName,
    required String password,
    required String email,
    required String role,
  }) async {
    Logger.debug('Attempting signup for host: $username');

    return _networkService.safeApiCall(
      apiCall: () => dio.post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.signUp}',
        data: {
          'username': username,
          'fullname': fullName,
          'email': email.trim(),
          'phone_number': '1234567899',
          'role': role,
          'password': password,
        },
      ),
      transform: (data) {
        Logger.debug('Transform data: $data');
        return AdminModelSignup.fromJson({
          ...data,
          'username': username,
          'fullname': fullName,
          'email': email,
          'role': role,
          'password': password,
        });
      },
    );
  }

  

  Future<void> logout() async {
    try {
      final response = await dio.post(
        ApiEndpoints.baseUrl + ApiEndpoints.logout,
      );

      if (response.statusCode != 200) {
        throw Exception('Logout failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Logout request failed: $e');
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      final response = await dio.post(
        ApiEndpoints.baseUrl + ApiEndpoints.forgotPassword,
        data: {'email': email},
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );

      print('\nResponse Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Success case - return normally
        return;
      }

      throw Exception(response.data['message'] ?? 'Failed to process request');
    } catch (e) {
      rethrow;
    }
  }
}
