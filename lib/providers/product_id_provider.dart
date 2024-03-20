import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/product_id_notifier.dart';

// final productIdProvider = StateProvider<String?>((ref) => null);
final productIdProvider =
    StateNotifierProvider<ProductIdNotifier, String>((ref) {
  return ProductIdNotifier();
});