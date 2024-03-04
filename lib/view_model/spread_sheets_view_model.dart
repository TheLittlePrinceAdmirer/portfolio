import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/product_admin.dart';
import 'package:http/http.dart' as http;

class SpreadSheetsService {
  Future<List<ProductAdmin>> fetchProducts() async {
    try {
      final spreadsheetId = '1YcS2I3v2w8CouXJFQhgX5XaeYCU2koNycxSR4sV58-s';
      final sheetName = 'products1';
      final apiKey = dotenv.env['API_KEY'];

      final url = Uri.parse(
          'https://sheets.googleapis.com/v4/spreadsheets/$spreadsheetId/values/$sheetName?key=$apiKey');

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> data = jsonData['values'];
        print('${data}');
        return data
            .skip(1) // ヘッダーをスキップ
            .map((json) => ProductAdmin.fromJson({
                  'productId': json[0],
                  'productName': json[1],
                  'productPrice': json[2],
                  'productImageUrl': json[3],
                }))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
