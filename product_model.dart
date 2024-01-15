// product_model.dart

class Product {
  final String image;
  final String name;
  final double price;
  bool addedToCart;

  Product(
      {required this.image,
      required this.name,
      required this.price,
      this.addedToCart = false});
}
