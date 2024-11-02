import 'package:flutter/material.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';
import 'package:shop_app/models/UserService.dart';
import 'package:shop_app/services/locator.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  final UserService _userService = locator<UserService>();

  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${_userService.cart.length} items",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
