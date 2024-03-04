import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/product.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../view_model/products_view_model.dart';
import '../view_model/firestore_page_view_model.dart';
import '../view_model/products_view_model.dart';
import '../view_model/spread_sheets_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider = ChangeNotifierProvider((ref) => ProductProvider());
final _productViewModel = ProductViewModel();

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];
  Future<void> fetchProducts() async {
    final products = await _productViewModel.fetchProducts();
    this.products = products;
    notifyListeners();
  }
}
