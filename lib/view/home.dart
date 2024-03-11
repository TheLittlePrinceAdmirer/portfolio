import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/routes.dart';
import 'cart_page_view.dart';
import 'login_page.dart';
import 'product_list_screen.dart';
import 'profile_page.dart';
import 'search_view.dart';
import 'favorite_products_view.dart'; // お気に入りページをインポート

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pages = [
    ProviderScope(
      child: ProductListView(),
    ),
    ProviderScope(
      child: FavoriteProductsView(),
    ),
    SearchPage(),
    ProviderScope(
      child: ProfilePage(),
    ),
  ];
  final _pageTitles = [
  'Product',
  'Favorites',
  'Search',
  'Profile',
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFFCE4EC),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
