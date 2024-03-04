import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/authentication_provider.dart';

class AuthenticationViewModel  extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// アカウント作成
  Future<void> createAccount(
      String email, String password, WidgetRef ref) async {
    try {
      /// credential にはアカウント情報が記録される
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('success:$email');

      /// ユーザ情報の更新
      ref.read(userProvider.state).state = credential.user;

      /// 画面に表示
      ref.read(signInStateProvider).state = 'アカウント作成に成功しました!';
    }

    /// アカウントに失敗した場合のエラー処理
    on FirebaseAuthException catch (e) {
      print(e);

      /// パスワードが弱い場合
      if (e.code == 'weak-password') {
        ref.read(signInStateProvider).state = 'パスワードが弱いです';

        /// メールアドレスが既に使用中の場合
      } else if (e.code == 'email-already-in-use') {
        ref.read(signInStateProvider).state = 'すでに使用されているメールアドレスです';
      }

      /// その他エラー
      else {
        ref.read(signInStateProvider).state = 'アカウント作成エラー';
      }
    } catch (e) {
      print(e);
    }
  }

  /// ログイン
  Future<void> signIn(String email, String password, WidgetRef ref) async {
    try {
      /// credential にはログイン情報が記録される
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('try:$email');

      /// ユーザ情報の更新
      ref.read(userProvider.state).state = credential.user;
      ref.read(signInStateProvider).state = 'ログイン成功しました!';
    }

    /// ログイン失敗時のエラー処理
    on FirebaseAuthException catch (e) {
      /// メールアドレスまたはパスワードが間違っている場合
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        ref.read(signInStateProvider).state = 'ログイン情報が間違っています';
      }

      /// その他エラー
      else {
        ref.read(signInStateProvider).state = 'ログインエラー';
      }
    } catch (e) {
      print(e);
    }
  }

  /// ログアウト
  Future<void> signOut(WidgetRef ref) async {
    await _auth.signOut();

    /// ユーザ情報のクリア
    ref.read(userProvider.state).state = null;

    /// 画面に表示
    ref.read(signInStateProvider).state = 'ログアウトしました';
  }
}
