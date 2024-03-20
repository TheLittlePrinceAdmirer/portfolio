import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/cart_widget.dart';

class CartPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    //最初のビルド時
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cartProvider.notifier).getCart(userId!);
      // ref.read(productProvider).fetchProducts();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.grey[800], // AppBarの背景色をグレーに設定
        elevation: 0, // AppBarの影を削除
        actions: [],
      ),
      body: CartProductGridView(),
    );
  }
}
