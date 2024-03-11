import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/authentication_provider.dart';
import '../view_model/authentication_view_model.dart';

class SignUpPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(signInStateProvider);
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController =
        TextEditingController();

    final authState = ref.watch(authProvider);
    final authNotifier = ref.watch(authProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('アカウント作成'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('message:$authState'),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'メールアドレス',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'パスワード',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'パスワード確認',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (_passwordController.text ==
                    _confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('アカウント情報を送信'),
                    ),
                  );

                  final email = _emailController.text;
                  final password = _passwordController.text;
                  await authNotifier.createAccount(email, password);
                  final authState = ref.watch(authProvider);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(authState),
                    ),
                  );
                  if (authState == 'アカウント作成に成功しました') {
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, '/home');
                  }

                  // await ref
                  //     .read(authProvider)
                  //     .createAccount(email, password, ref);
                } else {
                  // パスワードが一致しない場合のエラー処理
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('パスワードが一致しません'),
                    ),
                  );
                }
              },
              child: Text('アカウント作成'),
            ),
          ],
        ),
      ),
    );
  }
}
