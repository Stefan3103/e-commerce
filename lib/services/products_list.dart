import 'package:shop_app/models/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListOfProducts {
  List<Product> productList = [];

  void getProducts() async {
    final CollectionReference _fireStore =
        FirebaseFirestore.instance.collection("products");
    final products = _fireStore.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        productList.add(Product(
            id: element.id,
            image: element.data()['image'],
            title: element.data()['title'],
            price: element.data()['price'],
            description: element.data()['description'],
            isPopular: element.data()['popular']));
      });
    });
  }
}
