class ProductCartEntity {
  final String id;
  final String title;
  final int? quantity;
  final String imageCover;

  const ProductCartEntity({
    required this.id,
    required this.title,
    this.quantity,
    required this.imageCover,
  });
}
