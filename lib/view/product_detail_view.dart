import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product.dart';
import '../providers/product_id_provider.dart';
import '../providers/product_provider.dart';


class ProductDetailPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productId = ref.watch(productIdProvider);
    final product = ref.read(productProvider);


    // 商品情報がない場合の処理
    if (productId == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('商品名: ${product.products[0].name}'),
                  Text('価格: ${product.products[0].price}'),
                  // ... その他の表示項目
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // カートに追加機能
                        },
                        icon: Icon(Icons.shopping_cart),
                      ),
                      Text('カートに入れる'),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // お気に入りに追加機能
                  },
                  icon: Icon(Icons.favorite_border),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
