import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/auth_service.dart';
import '../view_model/authentication_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInStateNotifier extends ChangeNotifier {
  String _state = '';

  String get state => _state;

  set state(String value) {
    _state = value;
    notifyListeners();
  }
}

final signInStateProvider =
    ChangeNotifierProvider<SignInStateNotifier>((ref) => SignInStateNotifier());


// final signInStateProvider = StateProvider<String>((ref) => 'サインインまたはアカウントを作成してください');
final authStateProvider = StateProvider<String>((ref) => 'サインインまたはアカウントを作成してください');

/// ログインユーザーの情報
final userProvider = StateProvider<User?>((ref) => null);

/// Authクラスのインスタンス
// final authProvider = Provider((ref) => AuthenticationViewModel());
final authProvider =
    StateNotifierProvider<AuthNotifier, String>((ref) {
  return AuthNotifier();
});
