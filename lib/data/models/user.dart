class User {
  final String id;
  final String name;
  final String headline;
  final String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.headline,
    required this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      headline: json['headline'],
      imageUrl: json['image_url'] ?? '',
    );
  }
}