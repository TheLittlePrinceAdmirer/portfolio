import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_provider.dart';
import '../utils/images.dart';
import '../widgets/cart_widget.dart';

class ProductListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(productListProvider);
    int quantity = 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('商品一覧'),
      ),
      body: productList.when(
        data: (products) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 横3列
              crossAxisSpacing: 8.0, // 横スペース
              mainAxisSpacing: 8.0, // 縦スペース
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ExpansionTile(
                title: Column(
                  children: [
                    Image.network(
                      imageUrl,
                      width: 100, // 画像の幅
                      height: 100, // 画像の高さ
                      fit: BoxFit.cover, // 画像のフィット
                    ),
                    SizedBox(height: 8), // 余白
                    Text('商品名:${product.name}'),
                    Text('価格: ${product.price}円'),
                  ],
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QuantitySelector( // 数量選択ウィジェットを使用
                        quantity: quantity, // 初期数量
                        onChanged: (newQuantity) {
                          quantity = newQuantity;
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          // 購入アイコンが押された時の処理
                        },
                      ),
                      SizedBox(width: 8), // 余白
                      IconButton(
                        icon: Icon(Icons.favorite),
                        onPressed: () {
                          // ライクアイコンが押された時の処理
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, _) => Text('エラー: $error'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // プロバイダーを再読み込みして再取得を行う
          ref.refresh(productListProvider);
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
