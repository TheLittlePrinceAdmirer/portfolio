import 'package:flutter/material.dart';
import '../screens/product_list_screen.dart'; // ホームページのインポート
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'My App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductListScreen(), // ProductListScreenをホームに設定
      ),
    );
  }
}
