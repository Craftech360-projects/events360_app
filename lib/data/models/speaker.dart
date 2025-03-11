class Speaker {
  final int id;
  final String name;
  final String title;
  final String bio;
  final String imageUrl;

  Speaker({
    required this.id,
    required this.name,
    required this.title,
    required this.bio,
    required this.imageUrl,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      id: json['id'],
      name: json['name'],
      title: json['title'] ?? '',
      bio: json['bio'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'bio': bio,
      'image_url': imageUrl,
    };
  }
}