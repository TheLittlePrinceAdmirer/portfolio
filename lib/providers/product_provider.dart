import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';
import '../screens/product_list_screen.dart';

final productListProvider = FutureProvider<List<Product>>((ref) async {
  return _fetchProducts();
});

Future<List<Product>> _fetchProducts() async {
  try {
    final spreadsheetId = '1YcS2I3v2w8CouXJFQhgX5XaeYCU2koNycxSR4sV58-s';
    final sheetName = 'products1';
    final apiKey = 'AIzaSyChrzP3jVUVkGlk1ThZC1uSALwM9HoXeVE';

    final url = Uri.parse(
        'https://sheets.googleapis.com/v4/spreadsheets/$spreadsheetId/values/$sheetName?key=$apiKey');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData['values'];
      print('${data}');
      return data
          .skip(1) // ヘッダーをスキップ
          .map((json) => Product.fromJson({
                '商品ID': json[0],
                '商品名': json[1],
                '価格': json[2],
              }))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  } catch (e) {
    throw Exception('Failed to load products: $e');
  }
}
