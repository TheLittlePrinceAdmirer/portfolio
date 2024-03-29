import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cart_item_model.dart';
import '../model/product.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';

class CartProductGridView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    final productList = ref.watch(productProvider);
    final cartList = ref.watch(cartProvider);
    // if (cartList == null) {
    //   ref.read(cartProvider.notifier).getCart(userId!);
    // }
    // // ignore: unnecessary_null_comparison
    // if (productList == null) {
    //   ref.read(productProvider.notifier).fetchProducts();
    // }
    // Data check for empty list
    // final isEmpty = productList.products.isEmpty;
    // ignore: unnecessary_null_comparison
    if (cartList == null || productList == null) {
      // カートが空の場合の処理
      return _buildEmptyListView(ref, userId);
    } else {
      // カートにアイテムがある場合の処理
      return _buildListView(productList, cartList, ref);
    }
  }

  Widget _buildEmptyListView(WidgetRef ref, String? userId) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await ref.read(cartProvider.notifier).getCart(userId!);
          ref.read(productProvider.notifier).fetchProducts();
        },
        child: Text('Refresh'),
      ),
    );
  }

  Widget _buildListView(productList, cartList, WidgetRef ref) {
    final productIds = cartList!.products.keys.toList();

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(cartProvider.notifier).getCart(cartList.userId);
        ref.read(productProvider.notifier).fetchProducts();
      },
      child: ListView.builder(
        itemCount: productIds.length,
        itemBuilder: (context, index) {
          final productId = productIds[index];
          final product = productList.firstWhere(
              (product) => product.id == productId,
              orElse: () => Product(id: '', name: '', price: '', imageUrl: ''));

          return product != null
              ? _buildCartItemTile(product, cartList.products[productId]!, ref)
              : SizedBox();
        },
      ),
    );
  }

  Widget _buildCartItemTile(Product product, CartItem cartItem, WidgetRef ref) {
    final quantity = ref.read(quantityProvider);
    return Card(
      child: ListTile(
        leading: SizedBox(
          width: 100,
          height: 100,
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          product.name,
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price: ${product.price}',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              'Size: ${cartItem.size ?? 'N/A'}',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              'Color: ${cartItem.color ?? 'N/A'}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
        // trailing: Container(
        //   width: 100, // Specify the desired width
        //   child: QuantitySelector(
        //     quantity: cartItem.quantity,
        //     onChanged: (value) {
        //       ref.read(quantityProvider.notifier).state = value;
        //     },
        //   ),
        // ),
      ),
    );
  }
}

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            onChanged(quantity - 1);
          },
        ),
        Text('$quantity'), // ここに数量を表示する
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            onChanged(quantity + 1);
          },
        ),
      ],
    );
  }
}
