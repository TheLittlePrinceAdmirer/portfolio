import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cart_item_model.dart';

class CartNotifier extends StateNotifier<Cart?> {
  CartNotifier() : super(null);

  Future<void> getCart(String userId) async {
    final cartsCollection = FirebaseFirestore.instance.collection('carts');
    final cartQuery = cartsCollection.where('user_id', isEqualTo: userId);
    final cartSnapshot = await cartQuery.get();

    if (cartSnapshot.docs.isNotEmpty) {
      final cartDoc = cartSnapshot.docs.first;
      final cartData = cartDoc.data();
      final cart = Cart.fromMap(cartData);
      state = cart; // カートをStateにセットする
    } else {
      state = null; // カートが存在しない場合はStateをnullにセットする
    }
  }
}
