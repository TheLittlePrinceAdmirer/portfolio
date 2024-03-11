import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/authentication_provider.dart'; // authentication_provider.dartのパスを修正

class LogoutPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.watch(authProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text('ログアウト')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ログイン状態: $authState',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('ログアウトを送信'),
                  ),
                );
                await authNotifier.signOut();
                final authState = ref.watch(authProvider);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(authState),
                  ),
                );
                if (authState == 'ログアウトしました') {
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, '/home');
                }
              },
              child: Text('ログアウト'),
            ),
          ],
        ),
      ),
    );
  }
}
