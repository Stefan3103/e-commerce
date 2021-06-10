import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_bottom_nav_bar.dart';
import 'components/body.dart';
import 'package:shop_app/enums.dart';

class FavoritesScreen extends StatelessWidget {
  static String routeName = "/favorites";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favorite, ),
    );

  }
}
