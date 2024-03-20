import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/favorite_products_provider.dart';
import '../model/product.dart';
import '../providers/product_provider.dart';
import '../view_model/favorite_products_view_model.dart';

class FavoriteProductsGridView extends ConsumerWidget {
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
          ref.read(favoriteProductsProvider).fetchFavoriteProduct(userId!, ref);
        },
        child: Text('Refresh'),
      ),
    );
  }

  Widget _buildGridView(WidgetRef ref, String? userId) {
    final favoriteProductList = ref.watch(favoriteProductsProvider);
    return RefreshIndicator(
      onRefresh: () async {
        // await ref.read(productProvider).fetchProducts();
        await ref
            .read(favoriteProductsProvider)
            .fetchFavoriteProduct(userId!, ref);
      },
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: favoriteProductList.favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProductList.favoriteProducts[index];
          return Card(
            child: Column(
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
                        // お気に入りから削除するなどの処理を実行
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
