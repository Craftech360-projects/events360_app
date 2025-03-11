class User {
  final String uuid;
  final String email;
  final String name;
  final String? headline;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.uuid,
    required this.email,
    required this.name,
    this.headline,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['uuid'],
      email: json['email'],
      name: json['name'],
      headline: json['headline'],
      imageUrl: json['image_url'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'email': email,
        'name': name,
        'headline': headline,
        'image_url': imageUrl,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
