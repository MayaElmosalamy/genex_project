// lib/repositories/auth_repository.dart
import 'package:dio/dio.dart';
import '../services/api_service.dart';
import '../models/auth_response.dart';

class AuthRepository {
  final ApiService api;

  AuthRepository(this.api);

  Future<AuthResponse> signup({
    required String name,
    required String email,
    required String password,
    required String role, // "patient" or "doctor"
    Map<String, dynamic>? extraFields,
  }) async {
    final payload = {
      "name": name,
      "email": email,
      "password": password,
      "role": role,
      ...?extraFields,
    };

    final resp = await api.post('/signup/', payload); // for signup
    return AuthResponse.fromJson(resp.data);
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final resp = await api.post('/signin/', {
      "email": email,
      "password": password,
    });
    return AuthResponse.fromJson(resp.data);
  }
}
