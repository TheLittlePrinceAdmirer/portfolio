import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view/admin_login_page.dart';
import '../view/cart_page_view.dart';
import '../view/home.dart';
import '../view/login_page.dart';
import '../view/logout_page.dart';
import '../view/point_history_page.dart';
import '../view/product_detail_view.dart';
import '../view/profile_page.dart';
import '../view/search_view.dart';
import '../view/sign_up_page.dart';

class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String logout = '/logout';
  static const String profilePage = 'profile_page.dart';
  static const String search = '/search';
  static const String cart = '/cart';
  static const String pointHistory = '/pointHistory';
  static const String adminLoginPage = '/adminLoginPage';
  static const String productDetailPage = '/productDetailPage';

  static final routes = {
    home: (context) => Home(),
    login: (context) => ProviderScope(child: LoginPage()),
    signUp: (context) => ProviderScope(child: SignUpPage()),
    logout: (context) => ProviderScope(child: LogoutPage()),
    profilePage: (context) => ProviderScope(child: ProfilePage()),
    search: (context) => SearchPage(),
    cart: (context) => CartPage(),
    pointHistory: (context) => PointHistoryPage(),
    adminLoginPage: (context) => AdminLoginPage(),
    productDetailPage: (context) => ProductDetailPage(),
  };
}
