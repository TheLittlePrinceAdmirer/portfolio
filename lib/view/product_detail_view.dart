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
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // 渡された値を取り出す
    final String productId = arguments['productId'] as String;
    final List<Product> productList = arguments['productList'];
    Product? product = productList.firstWhere(
      (product) => product.id == productId,
      orElse: () => Product.empty(),
    );

    final quantity = ref.read(quantityProvider);
    final userId = FirebaseAuth.instance.currentUser?.uid;
    // 商品情報がない場合の処理
    if (productId == "") {
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
                  Expanded(
                    child: Image.network(
                      product.imageUrl,
                      loadingBuilder: (context, widget, event) {
                        if (event == null) {
                          return widget;
                        }
                        return CircularProgressIndicator();
                      },
                      width: MediaQuery.of(context).size.width * 0.8,
fit: BoxFit.fitWidth,                    ),
                  ),
                  Text('商品名: ${product.name}'),
                  Text('価格: ${product.price}'),
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
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                      ),
                      IconButton(
                        onPressed: () async {
                          if (userId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Unable to add item to cart due to unreadable login information.'),
                              ),
                            );
                          } else {
                            // カートに追加機能
                            await ref
                                .read(cartViewModelProvider.notifier)
                                .addToCart(
                                  userId, // ユーザーIDを取得
                                  productId, // 商品IDを取得
                                  quantity, // 選択された数量を取得
                                );
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Send to add item to cart'),
                              ),
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
