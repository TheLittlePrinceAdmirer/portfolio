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
      id: json['productId'],
      name: json['productName'] ?? '',
      price: json['productPrice'] ?? '',
      imageUrl: json['productImageUrl'] ?? '',
    );
  }
}
