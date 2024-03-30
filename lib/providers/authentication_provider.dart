import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Authクラスのインスタンス
// final authProvider = Provider((ref) => AuthenticationViewModel());
final authProvider =
    StateNotifierProvider<AuthNotifier, String>((ref) {
  return AuthNotifier();
});

