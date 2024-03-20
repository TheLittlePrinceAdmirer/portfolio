import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/product.dart';
import '../providers/product_provider.dart';

class FavoriteProductsViewModel extends ChangeNotifier {
  List<String> _favoriteProductIds = [];
  List<Product> _favoriteProducts = [];
  List<Product> get favoriteProducts =>
      _favoriteProducts; // favoriteProducts プロパティを追加
  Future<void> fetchFavoriteProduct(String userId, WidgetRef ref) async {
    try {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);
      final userDocSnapshot = await userDoc.get();
      if (userDocSnapshot.exists) {
        final List<dynamic> favoriteIds = userDocSnapshot.data()!['favorites'];
        _favoriteProductIds = List<String>.from(favoriteIds);
        final productList = ref.watch(productProvider);
        final products = productList;
        _favoriteProducts = products
            .where((product) => _favoriteProductIds.contains(product.id))
            .toList();
      } else {
        print('User document does not exist');
      }
    } catch (e) {
      print('Error fetching favorite product IDs: $e');
    }
    notifyListeners();
  }
}
