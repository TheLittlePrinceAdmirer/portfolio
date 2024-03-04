import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/authentication_provider.dart';
import 'logout_page.dart';
import 'sign_up_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final signInState = ref.watch(signInStateProvider);
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.grey[800], // AppBarの背景色をグレーに設定
        elevation: 0, // AppBarの影を削除
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart), // カートアイコンを追加
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[200], // ページ全体の背景色をグレーに設定
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              signInState,
              style: TextStyle(color: Colors.black), // テキストの色を黒に設定
            ),
            if (user != null) ...[
              Text(
                user.displayName ?? '',
                style: TextStyle(color: Colors.black), // テキストの色を黒に設定
              ),
              Text(
                user.email ?? '',
                style: TextStyle(color: Colors.black), // テキストの色を黒に設定
              ),
              // プロフィール編集ボタン
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // プロフィール編集画面へ遷移
                  },
                  icon: Icon(Icons.edit), // 編集アイコンを追加
                  label: Text('プロフィール編集'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[800], // ボタンの背景色をグレーに設定
                    onPrimary: Colors.white, // 文字色を白にする
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // ボタンの角を丸める
                    ),
                  ),
                ),
              ),
              // ログアウトボタン
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    // ログアウト画面へ遷移
                    Navigator.pushNamed(context, '/logout');
                  },
                  icon: Icon(Icons.logout), // ログアウトアイコンを追加
                  label: Text('ログアウト'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // ボタンの背景色を赤に設定
                    onPrimary: Colors.white, // 文字色を白にする
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // ボタンの角を丸める
                    ),
                  ),
                ),
              ),
            ] else ...[
              // ログインボタン
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  onPressed: () {
                    // ログイン画面へ遷移
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text('ログイン'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[800], // ボタンの背景色をグレーに設定
                    onPrimary: Colors.white, // 文字色を白にする
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // ボタンの角を丸める
                    ),
                  ),
                ),
              ),
              // 新規登録ボタン
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  onPressed: () {
                    // 新規登録画面へ遷移
                    Navigator.pushNamed(context, '/signUp');
                  },
                  child: Text('新規登録'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[800], // ボタンの背景色をグレーに設定
                    onPrimary: Colors.white, // 文字色を白にする
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // ボタンの角を丸める
                    ),
                  ),
                ),
              ),
            ],
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/adminLoginPage');
                },
                child: Text('Admin Login'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[800], // ボタンの背景色をグレーに設定
                  onPrimary: Colors.white, // 文字色を白にする
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // ボタンの角を丸める
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
