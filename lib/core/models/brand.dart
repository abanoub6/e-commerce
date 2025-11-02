class Brand {
  final String id;
  final String name;
  final String slug;
  final String image;

  const Brand({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json['_id'] as String,
    name: json['name'] as String,
    slug: json['slug'] as String,
    image: json['image'] as String,
  );
}
