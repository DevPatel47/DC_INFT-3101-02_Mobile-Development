import 'package:flutter/material.dart';
import '../models/appointment.dart';
import '../services/appointment_service.dart';

class AppointmentProvider with ChangeNotifier {
  final AppointmentService _appointmentService = AppointmentService();

  List<Appointment> _upcomingAppointments = [];
  List<Appointment> _pastAppointments = [];
  Appointment? _nextAppointment;
  bool _isLoading = false;
  String? _error;

  List<Appointment> get upcomingAppointments => _upcomingAppointments;
  List<Appointment> get pastAppointments => _pastAppointments;
  Appointment? get nextAppointment => _nextAppointment;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchAppointments() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final appointments = await _appointmentService.getMyAppointments();
      _upcomingAppointments = appointments['upcoming'] ?? [];
      _pastAppointments = appointments['past'] ?? [];

      _nextAppointment = await _appointmentService.getNextAppointment();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> bookAppointment({
    required String doctorId,
    required String date,
    required String time,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _appointmentService.createAppointment(
        doctorId: doctorId,
        date: date,
        time: time,
      );

      await fetchAppointments();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> cancelAppointment(String appointmentId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _appointmentService.cancelAppointment(appointmentId);

      await fetchAppointments();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
