class Metadata {
  final int currentPage;
  final int numberOfPages;
  final int limit;

  const Metadata({
    required this.currentPage,
    required this.numberOfPages,
    required this.limit,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    currentPage: json['currentPage'],
    numberOfPages: json['numberOfPages'],
    limit: json['limit'],
  );
}
