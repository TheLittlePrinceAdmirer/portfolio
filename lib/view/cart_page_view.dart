
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.grey[800], // AppBarの背景色をグレーに設定
        elevation: 0, // AppBarの影を削除
        actions: [
        ],
      ),
      body: Center(
        child: Text('Cart Page - Under Construction'),
      ),
    );
  }
}
