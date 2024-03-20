import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/favorite_products_provider.dart';
import '../providers/product_provider.dart';
import '../utils/images.dart';
import '../model/product.dart';
import '../view_model/favorite_products_view_model.dart';
import '../widgets/favorite_products_widget.dart';

class FavoriteProductsView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(productProvider).fetchProducts();
      if (userId != null) {
        ref.read(favoriteProductsProvider).fetchFavoriteProduct(userId, ref);
      }
    });
    return Scaffold(
      body: FavoriteProductsGridView(),
    );
  }
}
