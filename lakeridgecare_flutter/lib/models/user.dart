class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String theme;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.theme,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      theme: json['theme'] ?? 'light',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'theme': theme,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? theme,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      theme: theme ?? this.theme,
    );
  }
}
