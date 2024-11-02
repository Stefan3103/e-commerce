import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/UserService.dart';
import 'package:shop_app/services/locator.dart';
import '../../../size_config.dart';
import 'cart_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/Product.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Cart> cartList = [];
  var prodMap = new Map();
  CollectionReference _productRef =
      FirebaseFirestore.instance.collection("products");
  UserService _userService = locator<UserService>();

  final _fireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    print('drskaa' + _userService.cart.toString());

    for (var prod in _userService.cart) {
      if (!prodMap.containsKey(prod)) {
        prodMap[prod] = 1;
      } else
        prodMap[prod] += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: prodMap.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(prodMap.keys.toList()[index].toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                _userService.cart.removeWhere((element) =>
                    element == prodMap.keys.toList()[index].toString());
                _fireStore
                    .collection("user information")
                    .doc("${_userService.userId}")
                    .update({"cart": _userService.cart});
                prodMap.remove(prodMap.keys.toList()[index].toString());

                print(_userService.cart.toString() +
                    'aloekasdknaskjndkja ckasjdkasdnk sajdn');
              });
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: FutureBuilder(
                future: _productRef
                    .doc(prodMap.keys.toList()[index].toString())
                    .get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.black45),
                      ),
                    );
                  } else {
                    var data = snapshot.data?.data() as Map<String, dynamic>?;
                    return CartCard(
                      cart: Cart(
                        product: Product(
                            id: snapshot.data?.id ?? '',
                            title: data?['title']?.toString() ?? 'No Title',
                            description: data?['description']?.toString() ??
                                'No Description',
                            image: data?['image']?.toString() ?? 'No Image',
                            price: data?['price']?.toString() ?? '0'),
                        numOfItem: prodMap[prodMap.keys.toList()[index]] ?? 0,
                      ),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
