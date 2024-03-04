import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/favorite_products_provider.dart';
import '../utils/images.dart';
import '../view_model/favorite_products_view_model.dart';

class FavoriteProductsView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // FavoriteProductsViewModelを取得
    final viewModel = ref.watch(favoriteProductsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Products'),
      ),
      body: viewModel.favoriteProducts.isEmpty
          ? Center(
              child: Text('No favorite products yet.'),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: viewModel.favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = viewModel.favoriteProducts[index];
                return Card(
                  child: Column(
                    children: [
                      Image.network(
                        imageUrl, // 商品画像のURLを取得する必要があります
                        width: MediaQuery.of(context).size.width / 6,
                        fit: BoxFit.cover,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // データを再読み込みするなどの処理を実行
          ref.refresh(favoriteProductsViewModelProvider);
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
