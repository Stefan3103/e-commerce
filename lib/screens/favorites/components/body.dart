import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/services/locator.dart';
import 'package:shop_app/models/UserService.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final UserService _userService = locator<UserService>();

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _records = FirebaseFirestore.instance
        .collection("favorites")
        .where('user id', isEqualTo: _userService.userId)
        .snapshots();

    print('${_userService.cart} ovsena kasaaa');

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: StreamBuilder<QuerySnapshot>(
          stream: _records,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1 / 1.5,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: snapshot.data?.docs.length ?? 0,
                  itemBuilder: (_, index) {
                    List<DocumentSnapshot> products = snapshot.data?.docs ?? [];
                    print(products.isNotEmpty ? products.first : null);
                    return ProductFavList(
                      pList: products,
                      index: index,
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}

class ProductFavList extends StatelessWidget {
  final List<DocumentSnapshot> pList;
  final int index;

  const ProductFavList({Key? key, required this.pList, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('products')
          .doc(pList[index]['product id'].toString())
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var data = snapshot.data?.data() as Map<String, dynamic>?;
          print(data?['title']);
          return ProductCard(
            product: Product(
              isFavourite: true,
              id: snapshot.data?.id ?? '',
              title: data?['title'] as String? ?? '',
              description: data?['description'] as String? ?? '',
              image: data?['image'] as String? ?? '',
              price: data?['price'] as String? ?? '',
            ),
          );
        }
      },
    );
  }
}
