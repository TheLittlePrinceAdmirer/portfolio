import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/authentication_view_model.dart';

/// ログイン状態
// final signInStateProvider = StateProvider<String>((ref) => 'サインインまたはアカウントを作成してください');
final signInStateProvider = StateProvider((ref) => 'サインインまたはアカウントを作成してください');

/// ログインユーザーの情報
final userProvider = StateProvider<User?>((ref) => null);

/// Authクラスのインスタンス
final authProvider = Provider((ref) => AuthenticationViewModel());
