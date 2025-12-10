import '../core/api.dart';
import '../models/appointment.dart';

class AppointmentService {
  final ApiService _api = ApiService();

  Future<Appointment> createAppointment({
    required String doctorId,
    required String date,
    required String time,
  }) async {
    final response = await _api.post(
      '/appointments',
      {
        'doctorId': doctorId,
        'date': date,
        'time': time,
      },
      requiresAuth: true,
    );

    if (response['success'] == true) {
      return Appointment.fromJson(response['data']);
    }

    throw Exception(response['message'] ?? 'Failed to book appointment');
  }

  Future<Map<String, List<Appointment>>> getMyAppointments() async {
    final response = await _api.get('/appointments/me', requiresAuth: true);

    if (response['success'] == true) {
      final data = response['data'];

      final List<dynamic> upcomingJson = data['upcoming'] ?? [];
      final List<dynamic> pastJson = data['past'] ?? [];

      return {
        'upcoming':
            upcomingJson.map((json) => Appointment.fromJson(json)).toList(),
        'past': pastJson.map((json) => Appointment.fromJson(json)).toList(),
      };
    }

    throw Exception(response['message'] ?? 'Failed to fetch appointments');
  }

  Future<Appointment?> getNextAppointment() async {
    try {
      final response =
          await _api.get('/appointments/me/next', requiresAuth: true);

      if (response['success'] == true) {
        return Appointment.fromJson(response['data']);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<void> cancelAppointment(String appointmentId) async {
    final response = await _api.patch(
      '/appointments/$appointmentId/cancel',
      {},
      requiresAuth: true,
    );

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to cancel appointment');
    }
  }
}
