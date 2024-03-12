import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/authentication_provider.dart';

class ProductIdNotifier extends StateNotifier<String> {
  ProductIdNotifier() : super('');
  void setProductId(String productId) {
    state = productId;
  }
}
