import 'package:flutter/material.dart';
import '../models/review.dart';
import '../services/review_service.dart';

class ReviewProvider with ChangeNotifier {
  final ReviewService _reviewService = ReviewService();

  Map<String, List<Review>> _reviewsByDoctor = {};
  bool _isLoading = false;
  String? _error;

  List<Review> getReviewsForDoctor(String doctorId) {
    return _reviewsByDoctor[doctorId] ?? [];
  }

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchReviews(String doctorId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final reviews = await _reviewService.getReviewsByDoctor(doctorId);
      _reviewsByDoctor[doctorId] = reviews;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> submitReview({
    required String doctorId,
    required int rating,
    String? comment,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _reviewService.createOrUpdateReview(
        doctorId: doctorId,
        rating: rating,
        comment: comment,
      );

      await fetchReviews(doctorId);

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
