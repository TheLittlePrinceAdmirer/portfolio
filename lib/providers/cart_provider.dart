import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cart_item_model.dart';
import '../view_model/cart_view_model.dart';

final quantityProvider = StateProvider<int>((ref) => 1);

final cartViewModelProvider = StateNotifierProvider<CartViewModel, CartState>((ref) {
  return CartViewModel();
});

class CartState {
  final String userId;
  final Map<String, CartItem> products;

  CartState({required this.userId, required this.products});

  CartState copyWith({String? userId, Map<String, CartItem>? products}) {
    return CartState(
      userId: userId ?? this.userId,
      products: products ?? this.products,
    );
  }
}