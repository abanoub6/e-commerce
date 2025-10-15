class ProductEntity {
  final int sold;
  final List<String> images;
  final int ratingsQuantity;
  final String id;
  final String title;

  final String description;
  final int quantity;
  final int price;

  final int? priceAfterDiscount;

  const ProductEntity({
    required this.sold,
    required this.images,
    required this.ratingsQuantity,
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.price,

    this.priceAfterDiscount,
  });
}
