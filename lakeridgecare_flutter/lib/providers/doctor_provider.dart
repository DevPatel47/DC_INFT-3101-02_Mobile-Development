import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../services/doctor_service.dart';

class DoctorProvider with ChangeNotifier {
  final DoctorService _doctorService = DoctorService();

  List<Doctor> _doctors = [];
  List<Doctor> _filteredDoctors = [];
  List<String> _departments = [];
  bool _isLoading = false;
  String? _error;
  String? _selectedDepartment;
  String _searchQuery = '';

  List<Doctor> get doctors => _filteredDoctors;
  List<String> get departments => _departments;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get selectedDepartment => _selectedDepartment;
  String get searchQuery => _searchQuery;

  Future<void> fetchDoctors() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _doctors = await _doctorService.getDoctors();
      _filteredDoctors = _doctors;
      _departments = await _doctorService.getDepartments();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterByDepartment(String? department) {
    _selectedDepartment = department;
    _applyFilters();
  }

  void searchDoctors(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredDoctors = _doctors.where((doctor) {
      final matchesDepartment = _selectedDepartment == null ||
          _selectedDepartment!.isEmpty ||
          doctor.department.toLowerCase() == _selectedDepartment!.toLowerCase();

      final matchesSearch = _searchQuery.isEmpty ||
          doctor.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          doctor.department.toLowerCase().contains(_searchQuery.toLowerCase());

      return matchesDepartment && matchesSearch;
    }).toList();

    notifyListeners();
  }

  void clearFilters() {
    _selectedDepartment = null;
    _searchQuery = '';
    _filteredDoctors = _doctors;
    notifyListeners();
  }

  Future<Doctor?> getDoctorById(String doctorId) async {
    try {
      return await _doctorService.getDoctorById(doctorId);
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return null;
    }
  }
}
