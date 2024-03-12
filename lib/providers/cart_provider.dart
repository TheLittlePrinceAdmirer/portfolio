import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cart_item_model.dart';
import '../repository/cart_repository.dart';
import '../view_model/cart_view_model.dart';

final quantityProvider = StateProvider<int>((ref) => 1);

final cartViewModelProvider = StateNotifierProvider<CartViewModel, CartState>((ref) {
  return CartViewModel();
});


final cartProvider = StateNotifierProvider<CartNotifier, Cart?>((ref) {
  return CartNotifier();
});


