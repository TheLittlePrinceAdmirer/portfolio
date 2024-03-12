import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product.dart';
import '../providers/cart_provider.dart';
import '../providers/product_id_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/cart_widget.dart';

class ProductDetailPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productId = ref.watch(productIdProvider);
    final product = ref.read(productProvider);
    final quantity = ref.watch(quantityProvider);
    final selectedProduct = product.products[int.parse(productId!)];
    final userId = FirebaseAuth.instance.currentUser?.uid;

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
                  Text('商品名: ${selectedProduct.name}'),
                  Text('価格: ${selectedProduct.price}'),
                  // ... その他の表示項目
                  SizedBox(height: 20),
                  QuantitySelector(
                    quantity: quantity,
                    onChanged: (value) {
                      ref.read(quantityProvider.notifier).state = value;
                    },
                  ),
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
                          if (userId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Unable to add item to cart due to unreadable login information.'),
                              ),
                            );
                          } else {
                            // カートに追加機能
                            ref.read(cartViewModelProvider.notifier).addToCart(
                                  userId, // ユーザーIDを取得
                                  productId, // 商品IDを取得
                                  quantity, // 選択された数量を取得
                                );
                          }
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
