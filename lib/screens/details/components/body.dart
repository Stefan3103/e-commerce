import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/size_config.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/UserService.dart';
import 'package:shop_app/services/locator.dart';

class Body extends StatelessWidget {
  final Product product;
  final UserService _userService;
  final FirebaseFirestore _fireStore;

  const Body._({
    required this.product,
    required UserService userService,
    required FirebaseFirestore fireStore,
  })  : _userService = userService,
        _fireStore = fireStore,
        super(key: null);

  factory Body({required Product product}) => Body._(
        product: product,
        userService: locator<UserService>(),
        fireStore: FirebaseFirestore.instance,
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImages(product: product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
                TopRoundedContainer(
                  color: Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      ColorDots(product: product),
                      TopRoundedContainer(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.15,
                            right: SizeConfig.screenWidth * 0.15,
                            bottom: SizeConfig.getProportionateScreenWidth(40),
                            top: SizeConfig.getProportionateScreenWidth(15),
                          ),
                          child: DefaultButton(
                            text: "Add To Cart",
                            press: () {
                              try {
                                _userService.cart.add(product.id);
                                _fireStore
                                    .collection("user information")
                                    .doc("${_userService.userId}")
                                    .update({"cart": _userService.cart});
                                print("++++++++++++++++++++++0");
                                // Navigator.pushNamed(
                                //     context, OtpScreen.routeName);
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
