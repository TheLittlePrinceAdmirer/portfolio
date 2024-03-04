import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_provider.dart';
import '../utils/images.dart';
import '../view_model/firestore_page_view_model.dart';
import '../widgets/cart_widget.dart';

class ProductListView extends ConsumerWidget {
  final FirestoreService _firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(productProvider);
    int quantity = 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: productList.products.isEmpty
          ? Center(
              child: Text('No products yet.'),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: productList.products.length,
              itemBuilder: (context, index) {
                final product = productList.products[index];
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
          ref.refresh(productProvider);
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
