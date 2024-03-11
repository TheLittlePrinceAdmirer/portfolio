import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/authentication_provider.dart';

class AuthNotifier extends StateNotifier<String> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthNotifier() : super('');
  Future<void> createAccount(
      String email, String password) async {
    try {
      /// credential にはアカウント情報が記録される
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      state = 'アカウント作成に成功しました!';
    }

    /// アカウントに失敗した場合のエラー処理
    on FirebaseAuthException catch (e) {
      print(e);

      /// パスワードが弱い場合
      if (e.code == 'weak-password') {
        state = 'パスワードが弱いです';

        /// メールアドレスが既に使用中の場合
      } else if (e.code == 'email-already-in-use') {
        state = 'すでに使用されているメールアドレスです';
      }

      /// その他エラー
      else {
        state = 'アカウント作成エラー';
      }
    } catch (e) {
      state = 'エラー';

      print(e);
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      state = 'ログイン中...';
      /// credential にはログイン情報が記録される
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = 'ログイン成功しました!';
    }

    /// ログイン失敗時のエラー処理
    on FirebaseAuthException catch (e) {
      /// メールアドレスまたはパスワードが間違っている場合
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        state = 'ログイン情報が間違っています';
      }

      /// その他エラー
      else {
        state = 'ログインエラー';
      }
    } catch (e) {
      state = 'エラー';

      print(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    state = 'ログアウトしました';
  }
}
