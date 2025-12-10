import '../core/api.dart';
import '../models/review.dart';

class ReviewService {
  final ApiService _api = ApiService();

  Future<Review> createOrUpdateReview({
    required String doctorId,
    required int rating,
    String? comment,
  }) async {
    final response = await _api.post(
      '/reviews',
      {
        'doctorId': doctorId,
        'rating': rating,
        'comment': comment ?? '',
      },
      requiresAuth: true,
    );

    if (response['success'] == true) {
      return Review.fromJson(response['data']);
    }

    throw Exception(response['message'] ?? 'Failed to submit review');
  }

  Future<List<Review>> getReviewsByDoctor(String doctorId) async {
    final response = await _api.get('/reviews/$doctorId');

    if (response['success'] == true) {
      final List<dynamic> reviewsJson = response['data'];
      return reviewsJson.map((json) => Review.fromJson(json)).toList();
    }

    throw Exception(response['message'] ?? 'Failed to fetch reviews');
  }
}
