import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['productName'] ?? '',
      price: data['productPrice'] ?? '',
      imageUrl: data['productImageUrl'] ?? '',
    );
  }
  //変換
  Product toProduct() {
    return Product(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
    );
  }
  static Product empty() {
    return Product(
      id: '',
      name: '',
      price: '',
      imageUrl: '',
      // その他のプロパティにデフォルト値を設定
    );
  }
}
