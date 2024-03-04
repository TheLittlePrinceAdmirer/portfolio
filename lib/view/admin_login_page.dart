import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/model/product.dart';

import '../model/product_admin.dart';
import '../providers/product_provider.dart';
import '../view_model/firestore_page_view_model.dart';
import '../view_model/spread_sheets_view_model.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  String _password = ''; // パスワードの状態を保持する変数

  void _login(BuildContext context) {
    if (_password == '123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminPage()),
      );
    } else {
      // パスワードが正しくない場合、エラーメッセージを表示する
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid password.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _login(context),
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminPage extends ConsumerWidget {
  final FirestoreService _firestoreService = FirestoreService();
  final SpreadSheetsService _spreadSheetsService = SpreadSheetsService();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Admin Page!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final products = await _spreadSheetsService.fetchProducts();
                await _firestoreService.syncProductsFromSheet(products);
              },
              child: Text('Sync with Sheet(同期する)'), // ボタンに表示されるテキスト
            ),
          ],
        ),
      ),
    );
  }
}
