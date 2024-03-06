import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({Key? key, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch product details using productId and display them
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('Product ID: $productId'),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      // Add to cart functionality
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Add to favorites functionality
                  },
                  icon: Icon(Icons.favorite_border),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
