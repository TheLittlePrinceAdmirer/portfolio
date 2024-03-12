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
    return Scaffold(
      body: ProductGridView(),
    );
  }
}
