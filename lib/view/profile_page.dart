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
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィール'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(signInState),
            if (user != null) ...[
              Text(user.displayName ?? ''),
              Text(user.email ?? ''),
              // プロフィール編集ボタン
              ElevatedButton.icon(
                onPressed: () {
                  // プロフィール編集画面へ遷移
                },
                icon: Icon(Icons.edit), // 編集アイコンを追加
                label: Text('プロフィール編集'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // 白ベースのボタンにする
                  onPrimary: Colors.black, // 文字色を黒にする
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // ボタンの角を丸める
                  ),
                ),
              ),
              // ログアウトボタン
              ElevatedButton.icon(
                onPressed: () async {
                  // ログアウト画面へ遷移
                  Navigator.pushNamed(context, '/logout');
                },
                icon: Icon(Icons.logout), // ログアウトアイコンを追加
                label: Text('ログアウト'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // 白ベースのボタンにする
                  onPrimary: Colors.black, // 文字色を黒にする
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // ボタンの角を丸める
                  ),
                ),
              ),
            ] else ...[
              // ログインボタン
              ElevatedButton(
                onPressed: () {
                  // ログイン画面へ遷移
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('ログイン'),
              ),
              // 新規登録ボタン
              ElevatedButton(
                onPressed: () {
                  // 新規登録画面へ遷移
                  Navigator.pushNamed(context, '/signUp');
                },
                child: Text('新規登録'),
              ),
            ],
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/adminLoginPage');
              },
              child: Text('Admin Login'),
            ),
          ],
        ),
      ),
    );
  }
}
