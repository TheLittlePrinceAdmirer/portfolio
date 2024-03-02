import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? 'test';

  Future<void> addFavoriteItem(String itemIdToAdd) async {
    try {
      final userDoc = _firestore.collection('users').doc(userId);
      await userDoc.update({
        'favorites': FieldValue.arrayUnion([itemIdToAdd]),
      });
    } catch (e) {
      print('Error adding favorite item: $e');
    }
  }

  Future<void> addItemToCart(String itemIdToAdd, int quantity) async {
    try {
      final userDoc = _firestore.collection('users').doc(userId);
      await userDoc.update({
        'cart': FieldValue.arrayUnion([
          {'itemId': itemIdToAdd, 'quantity': quantity},
        ]),
      });
    } catch (e) {
      print('Error adding item to cart: $e');
    }
  }

  Future<List<String>> getFavoriteItems() async {
    try {
      final userDocSnapshot =
          await _firestore.collection('users').doc(userId).get();
      final favorites = userDocSnapshot.data()?['favorites'] ?? [];
      return List<String>.from(favorites);
    } catch (e) {
      print('Error getting favorite items: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    try {
      final userDocSnapshot =
          await _firestore.collection('users').doc(userId).get();
      final cart = userDocSnapshot.data()?['cart'] ?? [];
      return List<Map<String, dynamic>>.from(cart);
    } catch (e) {
      print('Error getting cart items: $e');
      return [];
    }
  }
}
