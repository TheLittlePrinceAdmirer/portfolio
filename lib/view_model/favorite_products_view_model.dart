import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/product.dart';

class FavoriteProductsViewModel extends ChangeNotifier {
  List<String> _favoriteProductIds = [];
  List<Product> _favoriteProducts = [];

  List<Product> get favoriteProducts => _favoriteProducts;

  Future<void> fetchFavoriteProductIds(String userId) async {
    try {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);
      final userDocSnapshot = await userDoc.get();
      if (userDocSnapshot.exists) {
        final List<dynamic> favoriteIds = userDocSnapshot.data()!['favorites'];
        _favoriteProductIds = List<String>.from(favoriteIds);
      } else {
        print('User document does not exist');
      }
    } catch (e) {
      print('Error fetching favorite product IDs: $e');
    }
    notifyListeners();
  }

  Future<void> fetchFavoriteProducts() async {
    try {
      final List<Product> favoriteProducts = [];
      for (String productId in _favoriteProductIds) {
        final productDoc = await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .get();
        if (productDoc.exists) {
          final productData = productDoc.data();
          final Product product = Product(
            id: productId,
            name: productData!['name'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],

            // 他の必要な商品情報をここに追加する
          );
          favoriteProducts.add(product);
        }
      }
      _favoriteProducts = favoriteProducts;
    } catch (e) {
      print('Error fetching favorite products: $e');
    }
    notifyListeners();
  }
}
