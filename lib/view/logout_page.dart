import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/authentication_provider.dart'; // authentication_provider.dartのパスを修正

class LogoutPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(signInStateProvider);

    return Scaffold(
      appBar: AppBar(title: Text('ログアウト')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ログイン状態: $signInState',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await ref.read(authProvider).signOut(ref);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('ログアウトを送信'),
                    ),);
              },
              child: Text('ログアウト'),
            ),
          ],
        ),
      ),
    );
  }
}
