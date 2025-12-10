import '../core/api.dart';
import '../models/doctor.dart';

class DoctorService {
  final ApiService _api = ApiService();

  Future<List<Doctor>> getDoctors({
    String? department,
    String? search,
  }) async {
    String endpoint = '/doctors';

    List<String> queryParams = [];
    if (department != null && department.isNotEmpty) {
      queryParams.add('department=$department');
    }
    if (search != null && search.isNotEmpty) {
      queryParams.add('search=$search');
    }

    if (queryParams.isNotEmpty) {
      endpoint += '?${queryParams.join('&')}';
    }

    final response = await _api.get(endpoint);

    if (response['success'] == true) {
      final List<dynamic> doctorsJson = response['data'];
      return doctorsJson.map((json) => Doctor.fromJson(json)).toList();
    }

    throw Exception(response['message'] ?? 'Failed to fetch doctors');
  }

  Future<Doctor> getDoctorById(String doctorId) async {
    final response = await _api.get('/doctors/$doctorId');

    if (response['success'] == true) {
      return Doctor.fromJson(response['data']);
    }

    throw Exception(response['message'] ?? 'Failed to fetch doctor details');
  }

  Future<List<String>> getDepartments() async {
    final doctors = await getDoctors();
    final departments = doctors.map((d) => d.department).toSet().toList();
    departments.sort();
    return departments;
  }
}
