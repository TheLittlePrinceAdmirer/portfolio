// cart_view_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/model/product.dart';

import '../model/cart_item_model.dart';
import '../providers/cart_provider.dart';

class CartViewModel extends StateNotifier<CartState> {
    CartViewModel() : super(CartState(userId: '', products: {}));

  Future<void> addToCart(String userId, String productId, int quantity) async {
    final cartsCollection = FirebaseFirestore.instance.collection('carts');
    final cartQuery = cartsCollection.where('user_id', isEqualTo: userId);
    final cartSnapshot = await cartQuery.get();

    if (cartSnapshot.docs.isNotEmpty) {
      // カートが既に存在する場合は、商品を追加またはアップデートする
      final cartDoc = cartSnapshot.docs.first;
      await cartDoc.reference.update({
        'products.$productId.quantity': quantity,
        'products.$productId.size': null,
        'products.$productId.color': null,
      });
    } else {
      // カートが存在しない場合は、新しいドキュメントを作成する
      final newCartDoc = cartsCollection.doc();
      await newCartDoc.set({
        'user_id': userId,
        'products': {
          productId: {'quantity': quantity, 'size': null, 'color': null},
        },
      });
    }
  }
}
