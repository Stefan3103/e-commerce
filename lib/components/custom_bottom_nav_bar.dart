import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/favorites/favorites_screen.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    const inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context: context,
              icon: "assets/icons/Shop Icon.svg",
              selectedMenu: MenuState.home,
              routeName: HomeScreen.routeName,
            ),
            _buildNavItem(
              context: context,
              icon: "assets/icons/Heart Icon.svg",
              selectedMenu: MenuState.favorite,
              routeName: FavoritesScreen.routeName,
            ),
            _buildNavItem(
              context: context,
              icon: "assets/icons/Cart Icon.svg",
              selectedMenu: MenuState.cart,
              routeName: CartScreen.routeName,
              iconHeight: 22,
            ),
            _buildNavItem(
              context: context,
              icon: "assets/icons/User Icon.svg",
              selectedMenu: MenuState.profile,
              routeName: ProfileScreen.routeName,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required String icon,
    required MenuState selectedMenu,
    required String routeName,
    double? iconHeight,
  }) {
    final isSelected = this.selectedMenu == selectedMenu;
    return IconButton(
      icon: SvgPicture.asset(
        icon,
        height: iconHeight,
        colorFilter: ColorFilter.mode(
          isSelected ? kPrimaryColor : const Color(0xFFB6B6B6),
          BlendMode.srcIn,
        ),
      ),
      onPressed: () {
        if (ModalRoute.of(context)?.settings.name != routeName) {
          Navigator.pushNamed(context, routeName);
        }
      },
    );
  }
}
