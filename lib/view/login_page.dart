import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/authentication_provider.dart';
import '../view_model/authentication_view_model.dart';
import '../widgets/snackbar_widget.dart';

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final signInState = ref.watch(signInStateProvider);
    // final authState = ref.watch(authStateProvider);
    final authState = ref.watch(authProvider);
    final authNotifier = ref.watch(authProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('message:$authState'),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'メールアドレス'),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'パスワード'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // ignore: use_build_context_synchronously
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('ログイン情報送信'),
                  ),
                );
                final email = emailController.text;
                final password = passwordController.text;
                // await ref
                //     .read(authProvider)
                //     .signIn(email, password, ref, context);
                //完了を待機
                await authNotifier.signIn(email, password);
                // authProviderを使って状態を監視し、変更あるか
                final authState = ref.watch(authProvider);

                // final lastSnackBar = SnackBar(content: Text(authState));
                // ignore: use_build_context_synchronously
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(authState),
                  ),
                );
                if (authState == 'ログイン成功しました!') {
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, '/home');
                }
              },
              child: Text('ログイン'),
            ),
          ],
        ),
      ),
    );
  }
}
