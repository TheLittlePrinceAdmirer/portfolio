import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../providers/product_provider.dart';

// // providers/product_provider.dartから
// final productListProvider = FutureProvider<List<Product>>((ref) async {
//   // 非同期処理で商品一覧を取得
//   final products = await _fetchProducts();
//   return products;
// });

class ProductListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(productListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('商品一覧'),
      ),
      body: productList.when(
        data: (products) {
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                leading: Image.network(
                  'https://osusume.mynavi.jp/uploads/article/image/5691/article_header_%E9%9D%92%E3%81%84%E8%83%8C%E6%99%AF%E3%81%AE%E4%B8%8A%E3%81%AB%E3%82%AF%E3%83%A9%E3%83%95%E3%83%88%E7%B4%99%E3%81%A8%E9%9D%92%E3%81%84%E3%83%AA%E3%83%9C%E3%83%B3%E3%81%A7%E5%8C%85%E8%A3%85%E3%81%95%E3%82%8C%E3%81%9F%E3%83%97%E3%83%AC%E3%82%BC%E3%83%B3%E3%83%88%E3%81%8C%E7%BD%AE%E3%81%84%E3%81%A6%E3%81%82%E3%82%8A%E3%81%BE%E3%81%99_%E3%81%8D%E3%82%89%E3%81%8D%E3%82%89%E3%81%A8%E3%81%97%E3%81%9F%E6%98%9F%E5%BD%A2%E3%81%AE%E3%83%A9%E3%83%A1%E3%81%8C%E6%95%A3%E3%82%89%E3%81%B0%E3%81%A3%E3%81%A6%E3%81%84%E3%81%BE%E3%81%99_.jpg', // 商品の画像のURL
                  width: 50, // 画像の幅
                  height: 50, // 画像の高さ
                ),
                title: Text('商品:${product.name}'),
                subtitle: Text('価格: ${product.price}円'),
                onTap: () {
                  // 商品詳細ページに遷移する処理を追加
                },
              );
            },
          );
        },
        loading: () => CircularProgressIndicator(),
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
