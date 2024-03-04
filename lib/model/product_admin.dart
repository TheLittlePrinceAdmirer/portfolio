import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductAdmin {
  final String id;
  final String name;
  final String price;
  final String imageUrl;

  ProductAdmin({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
  factory ProductAdmin.fromJson(Map<String, dynamic> json) {
    return ProductAdmin(
      id: json['商品ID'],
      name: json['商品名'] ?? '',
      price: json['価格'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
