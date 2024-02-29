import 'package:csv_spread_sheets_demo/view/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
            // ログイン状態に応じてボタンを表示
            if (user != null) ...[
              // プロフィール編集ボタン
              Text(user.displayName ?? ''),
              Text(user.email ?? ''),
              ElevatedButton(
                onPressed: () {
                  // プロフィール編集画面へ遷移
                },
                child: Text('プロフィール編集'),
              ),
              // ログアウトボタン
              ElevatedButton(
                onPressed: () async {
                  // ログアウト画面へ遷移
                  Navigator.pushNamed(context, '/logout');
                },
                child: Text('ログアウト'),
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
          ],
        ),
      ),
    );
  }
}
