class Sponsor {
  final int id;
  final String name;
  final String tier;
  final String logoUrl;
  final String booth;

  Sponsor({
    required this.id,
    required this.name,
    required this.tier,
    required this.logoUrl,
    required this.booth,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
      id: json['id'],
      name: json['name'],
      tier: json['tier'] ?? '',
      logoUrl: json['logo_url'] ?? '',
      booth: json['booth'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tier': tier,
      'logo_url': logoUrl,
      'booth': booth,
    };
  }
}