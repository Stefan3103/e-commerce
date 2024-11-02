import 'package:shop_app/models/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListOfProducts {
  final List<Product> productList = [];
  final CollectionReference _fireStore =
      FirebaseFirestore.instance.collection("products");

  Future<void> getProducts() async {
    try {
      final QuerySnapshot snapshot = await _fireStore.get();
      productList.clear(); // Clear existing products before adding new ones
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        productList.add(Product(
          id: doc.id,
          image: data['image'] as String? ?? '',
          title: data['title'] as String? ?? '',
          price: (data['price'] ?? '0').toString(), // Convert to String
          description: data['description'] as String? ?? '',
          isPopular: data['popular'] as bool? ?? false,
          category: data['category'] as String? ?? 'uncategorized',
          rating: _parseRating(data['rating']),
          isFavourite: data['isFavourite'] as bool? ?? false,
        ));
      }
    } catch (e) {
      print('Error fetching products: $e');
      // You might want to rethrow the error or handle it differently
    }
  }

  double _parseRating(dynamic rating) {
    if (rating == null) return 0.0;
    if (rating is num) return rating.toDouble();
    if (rating is String) {
      return double.tryParse(rating) ?? 0.0;
    }
    return 0.0;
  }

  // New method to fetch products by category
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final QuerySnapshot snapshot = await _fireStore.get();

      return snapshot.docs.where((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final productCategory =
            (data['category'] as String? ?? '').toLowerCase();
        return productCategory == category.toLowerCase();
      }).map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Product(
          id: doc.id,
          image: data['image'] as String? ?? '',
          title: data['title'] as String? ?? '',
          price: (data['price'] ?? '0').toString(),
          description: data['description'] as String? ?? '',
          isPopular: data['popular'] as bool? ?? false,
          category: data['category'] as String? ?? 'other',
          rating: _parseRating(data['rating']),
          isFavourite: data['isFavourite'] as bool? ?? false,
        );
      }).toList();
    } catch (e) {
      print('Error fetching products by category: $e');
      return []; // Return an empty list in case of error
    }
  }
}
