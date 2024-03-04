import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/favorite_products_provider.dart';
import '../model/product.dart';
import '../providers/product_provider.dart';
import '../view_model/favorite_products_view_model.dart';
import '../view_model/firestore_page_view_model.dart';

class ProductGridView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProductList = ref.watch(favoriteProductsProvider);
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    // データが空の場合はリフレッシュボタンを表示
    final isEmpty = favoriteProductList.favoriteProducts.isEmpty;

    return isEmpty
        ? _buildEmptyGridView(ref, userId)
        : _buildGridView(ref, userId);
  }

  Widget _buildEmptyGridView(WidgetRef ref, String? userId) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          ref.read(productProvider).fetchProducts();
        },
        child: Text('Refresh'),
      ),
    );
  }

  Widget _buildGridView(WidgetRef ref, String? userId) {
    final productList = ref.watch(productProvider);
    final FirestoreService firestoreService = FirestoreService();

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(productProvider).fetchProducts();
      },
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: productList.products.length,
        itemBuilder: (context, index) {
          final product = productList.products[index];
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Image.network(
                    product.imageUrl,
                    width: MediaQuery.of(context).size.width / 6,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  '商品名: ${product.name}',
                  style: TextStyle(fontSize: 9),
                ),
                Row(
                  children: [
                    Text(
                      '価格: ${product.price}',
                      style: TextStyle(fontSize: 6),
                    ),
                    const SizedBox(width: 1),
                    IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {
                        firestoreService.addToFavorites(product);
                      },
                    ),
                    const SizedBox(width: 1),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
