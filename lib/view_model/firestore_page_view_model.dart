import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/product.dart';
import '../model/product_admin.dart';
import 'spread_sheets_view_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? 'test';
  final SpreadSheetsService _spreadSheetsService = SpreadSheetsService();
  Future<void> addToFavorites(Product product) async {
    print('${product.id}');
    try {
      final userDoc = _firestore.collection('users').doc(userId);
      final userDocSnapshot = await userDoc.get();
      if (userDocSnapshot.exists) {
        // 既存のお気に入りリストがある場合は既存のリストに商品を追加
        await userDoc.update({
          'favorites': FieldValue.arrayUnion([product.id]),
        });
      } else {
        // 既存のお気に入りリストがない場合は新しいドキュメントを作成して商品を追加
        await userDoc.set({
          'favorites': [product.id],
        });
      }
    } catch (e) {
      print('Error adding to favorites: $e');
    }
  }

  Future<void> removeFromFavorites(String productId) async {
    try {
      final userDoc = _firestore.collection('users').doc(userId);
      await userDoc.update({
        'favorites': FieldValue.arrayRemove([productId]),
      });
    } catch (e) {
      print('Error removing from favorites: $e');
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await _firestore.collection('products').doc(product.id).set(
        {
          'name': product.name,
          'price': product.price,
          'imageUrl': product.imageUrl,
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> syncProductsFromSheet(List<ProductAdmin> products) async {
    try {
      // productsコレクションに商品データを追加
      for (var product in products) {
        await _firestore.collection('products').doc(product.id).set({
          'name': product.name,
          'price': product.price,
          'imageUrl': product.imageUrl,
        });
      }
    } catch (e) {
      throw Exception('Error adding products to Firestore: $e');
    }
  }
}
