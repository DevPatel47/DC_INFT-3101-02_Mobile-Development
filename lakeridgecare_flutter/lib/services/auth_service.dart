import '../core/api.dart';
import '../models/user.dart';

class AuthService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    String theme = 'light',
  }) async {
    final response = await _api.post(
      '/auth/register',
      {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'theme': theme,
      },
    );

    if (response['success'] == true) {
      final token = response['data']['token'];
      final user = User.fromJson(response['data']['user']);

      await _api.saveToken(token);

      return {
        'user': user,
        'token': token,
      };
    }

    throw Exception(response['message'] ?? 'Registration failed');
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _api.post(
      '/auth/login',
      {
        'email': email,
        'password': password,
      },
    );

    if (response['success'] == true) {
      final token = response['data']['token'];
      final user = User.fromJson(response['data']['user']);

      await _api.saveToken(token);

      return {
        'user': user,
        'token': token,
      };
    }

    throw Exception(response['message'] ?? 'Login failed');
  }

  Future<User> getMe() async {
    final response = await _api.get('/auth/me', requiresAuth: true);

    if (response['success'] == true) {
      return User.fromJson(response['data']);
    }

    throw Exception(response['message'] ?? 'Failed to get user data');
  }

  Future<void> logout() async {
    await _api.deleteToken();
  }

  Future<bool> isLoggedIn() async {
    final token = await _api.getToken();
    return token != null && token.isNotEmpty;
  }
}
