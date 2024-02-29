import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  final String id;
  final String name;
  final String price;

  Product({required this.id, required this.name, required this.price});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['商品ID'],
      name: json['商品名'],
      price: json['価格'],
    );
  }
}
