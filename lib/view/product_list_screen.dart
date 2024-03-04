import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_provider.dart';
import '../utils/images.dart';
import '../view_model/firestore_page_view_model.dart';
import '../widgets/cart_widget.dart';
import '../widgets/product_widget.dart';

class ProductListView extends ConsumerWidget {
  final FirestoreService _firestoreService = FirestoreService();
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //最初のビルド時
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productProvider).fetchProducts();
    });
    int quantity = 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        backgroundColor: Colors.grey[800], // AppBarの背景色をグレーに設定
        elevation: 0, // AppBarの影を削除
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart), // カートアイコンを追加
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: ProductGridView(),
    );
  }
}
