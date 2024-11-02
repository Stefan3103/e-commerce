import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_bottom_nav_bar.dart';
import 'components/body.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/models/UserService.dart';
import 'package:shop_app/services/locator.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserService _userService = locator<UserService>();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    // Call getUser() without awaiting to maintain current behavior
    _userService.getUser();
    // If you want to perform any actions after user data is loaded,
    // you can add a callback to the getUser method in UserService
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
