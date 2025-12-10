class Doctor {
  final String id;
  final String name;
  final String department;
  final String bio;
  final String imageUrl;
  final double ratingAvg;
  final int ratingCount;

  Doctor({
    required this.id,
    required this.name,
    required this.department,
    required this.bio,
    required this.imageUrl,
    required this.ratingAvg,
    required this.ratingCount,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      department: json['department'] ?? '',
      bio: json['bio'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      ratingAvg: (json['ratingAvg'] ?? 0).toDouble(),
      ratingCount: json['ratingCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'bio': bio,
      'imageUrl': imageUrl,
      'ratingAvg': ratingAvg,
      'ratingCount': ratingCount,
    };
  }
}
