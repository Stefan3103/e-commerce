import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  List<Product> productList;
  @override
  Widget build(BuildContext context) {
    CollectionReference _records =
    FirebaseFirestore.instance.collection("products");
    return SafeArea(
      child:         Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: FutureBuilder<QuerySnapshot>(
          future: _records.get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              //staviti da izbaca tekst greške
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              // Map<String, dynamic> data = snapshot.data.data();
              var docs = snapshot.data.docs;

              productList = [];
              int i = 0;
              for (var doc in docs) {
                productList.add(Product(
                    id: doc.id.toString(),
                    title: doc.data()['title'].toString(),
                    description: doc.data()['description'].toString(),
                    image: doc.data()['image'].toString(),
                    price: doc.data()['price'].toString(),
                    // isFavourite: doc.data()['favorite'],
                    isPopular: doc.data()['popular']));
                print(productList[i].id);
                i++;
              }
              return GridView.count(
crossAxisSpacing: 20,
mainAxisSpacing: 15,
childAspectRatio: 1/1.5,
                crossAxisCount: 2,
                  children: [
                    ...List.generate(
                      productList.length,
                          (index) {
                        if (productList[index].isPopular)
                          return ProductCard(product: productList[index], leftPadding: 0,);

                        return SizedBox
                            .shrink(); // here by default width and height is 0
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],

              );
            }

            return Text("loading");
          },
        ),
      ),
    );
  }
}
