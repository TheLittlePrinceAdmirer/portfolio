// class CartItem {
//   final int quantity;
//   final String? size;
//   final String? color;

//   CartItem({required this.quantity, this.size, this.color});
// }
class Cart {
  final String userId;
  final Map<String, CartItem> products;

  Cart({
    required this.userId,
    required this.products,
  });

  factory Cart.fromMap(Map<String, dynamic> map) {
    final Map<String, dynamic> productsMap = map['products'];
    final products = productsMap.map((key, value) =>
        MapEntry(key, CartItem.fromMap(value as Map<String, dynamic>)));

    return Cart(
      userId: map['user_id'] as String,
      products: products,
    );
  }
}

class CartItem {
  final int quantity;
  final String? size;
  final String? color;

  CartItem({
    required this.quantity,
    this.size,
    this.color,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      quantity: map['quantity'] as int,
      size: map['size'] as String?,
      color: map['color'] as String?,
    );
  }
}


class CartState {
  final String userId;
  final Map<String, CartItem> products;

  CartState({required this.userId, required this.products});

  CartState copyWith({String? userId, Map<String, CartItem>? products}) {
    return CartState(
      userId: userId ?? this.userId,
      products: products ?? this.products,
    );
  }
}