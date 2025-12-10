import '../core/api.dart';
import '../models/user.dart';

class UserService {
  final ApiService _api = ApiService();

  Future<User> getProfile() async {
    final response = await _api.get('/users/me', requiresAuth: true);

    if (response['success'] == true) {
      return User.fromJson(response['data']);
    }

    throw Exception(response['message'] ?? 'Failed to fetch profile');
  }

  Future<User> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? theme,
  }) async {
    final Map<String, dynamic> body = {};

    if (name != null) body['name'] = name;
    if (email != null) body['email'] = email;
    if (phone != null) body['phone'] = phone;
    if (theme != null) body['theme'] = theme;

    final response = await _api.patch(
      '/users/me',
      body,
      requiresAuth: true,
    );

    if (response['success'] == true) {
      return User.fromJson(response['data']);
    }

    throw Exception(response['message'] ?? 'Failed to update profile');
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final response = await _api.patch(
      '/users/me/password',
      {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
      requiresAuth: true,
    );

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to update password');
    }
  }
}
