import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product.dart';
import '../providers/product_provider.dart';

class CartProductGridView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(productProvider);

    // Data check for empty list
    final isEmpty = productList.products.isEmpty;

    return isEmpty
        ? _buildEmptyGridView(ref, userId)
        : _buildGridView(productList);
  }

  Widget _buildEmptyGridView(WidgetRef ref, String? userId) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          //カート取得メソッド呼ぶ
        },
        child: Text('Refresh'),
      ),
    );
  }

  Widget _buildProductList(final List<Product> productList) {
    return RefreshIndicator(
      onRefresh: () async {
        // Implement refresh logic to fetch new data if needed
        // カート取得メソッド呼ぶ
      },
      child: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
          return Card(
            child: ListTile(
              leading: SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                product.name,
                style: TextStyle(fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price: ${product.price}',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Size: ${product.size}',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Color: ${product.color}',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              trailing: SizedBox(
                width: 100, // Adjust as needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    QuantitySelector(
                    quantity: quantity,
                    onChanged: (value) {
                      //quantityプロバイダの値を更新
                      ref.read(quantityProvider.notifier).state = value;
                    },
                  ),
                  ],
                ),
              ),
            ),
          );
        },
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
