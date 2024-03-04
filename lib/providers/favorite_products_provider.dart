import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/favorite_products_view_model.dart';

final favoriteProductsViewModelProvider =
    ChangeNotifierProvider((ref) => FavoriteProductsViewModel());
