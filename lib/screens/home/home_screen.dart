import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_bottom_nav_bar.dart';
import 'components/body.dart';
import 'package:shop_app/enums.dart';


class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  // void getProducts() async {
  //   print("eeeeeeejjjjj56456456456456");
  //   final QuerySnapshot _records =
  //       await FirebaseFirestore.instance.collection("products").get();
  //
  //   var docs = _records.docs;
  //   print("eeeeeeejjjjj");
  //   for (var doc in docs) {
  //     print("odje ide broj clanova: " + productList.length.toString());
  //     productList.add(Product(
  //         id: doc.id,
  //         title: doc.data()['title'].toString(),
  //         description: doc.data()['description'].toString(),
  //         image: doc.data()['image'].toString()));
  //     print(doc.id);
  //     print("cccc" + doc.data().toString());
  //     print(doc.data()['description']);
  //   }

  // print("cccc" + docs.first.data().keys.first);
  // }
  // get().then((QuerySnapshot snapshot) {
  //   snapshot.docs.forEach((element) {
  //     productList.add(Product(
  //         id: element.id,
  //         image: element.data()['image'],
  //         title: element.data()['title'],
  //         price: element.data()['price'],
  //         description: element.data()['description'],
  //         isPopular: element.data()['popular']));
  //     print(element.data());
  //   });
  // });

  @override
  Widget build(BuildContext context) {
    // print("odje ide broj clanova: " + productList.length.toString());
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
