import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product.dart';

class ProductViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> fetchProducts() async {
    final productsCollection = _firestore.collection('products');
    final snapshot = await productsCollection.get();
    return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
  }
}