Future<Cart?> getCart(String userId) async {
  final cartsCollection = FirebaseFirestore.instance.collection('carts');
  final cartQuery = cartsCollection.where('user_id', isEqualTo: userId);
  final cartSnapshot = await cartQuery.get();

  if (cartSnapshot.docs.isNotEmpty) {
    final cartDoc = cartSnapshot.docs.first;
    final cartData = cartDoc.data();
    // ここでCartオブジェクトを作成して返す
    return Cart.fromMap(cartData);
  } else {
    return null;
  }
}