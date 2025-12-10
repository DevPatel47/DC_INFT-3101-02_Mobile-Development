class Review {
  final String id;
  final String userId;
  final String doctorId;
  final int rating;
  final String comment;
  final String? userName;
  final DateTime? createdAt;

  Review({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.rating,
    required this.comment,
    this.userName,
    this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'] ?? json['id'] ?? '',
      userId: json['userId'] is String
          ? json['userId']
          : json['userId']?['_id'] ?? '',
      doctorId: json['doctorId'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      userName: json['userId'] is Map ? json['userId']['name'] : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'rating': rating,
      'comment': comment,
    };
  }
}
