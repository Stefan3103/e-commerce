import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class SocalCard extends StatelessWidget {
  const SocalCard({
    Key? key,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.getProportionateScreenWidth(10)),
        padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(12)),
        height: SizeConfig.getProportionateScreenHeight(50),
        width: SizeConfig.getProportionateScreenWidth(60),
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          icon,
        ),
      ),
    );
  }
}
