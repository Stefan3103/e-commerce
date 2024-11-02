import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/category_products/category_products_screen.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "Electronics"},
      {"icon": "assets/icons/wears.svg", "text": "Wears"},
      {"icon": "assets/icons/Game Icon.svg", "text": "Game"},
      {"icon": "assets/icons/watches.svg", "text": "Watches"},
      {"icon": "assets/icons/Discover.svg", "text": "More"},
    ];
    return Padding(
      padding: EdgeInsets.all(SizeConfig.getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {
              Navigator.pushNamed(
                context,
                '/category_products',
                arguments: categories[index]["text"],
              );
            },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: SizeConfig.getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.all(SizeConfig.getProportionateScreenWidth(15)),
              height: SizeConfig.getProportionateScreenWidth(55),
              width: SizeConfig.getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon, color: Color(0xFFFF7643)),
            ),
            SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center, textScaleFactor: 0.75)
          ],
        ),
      ),
    );
  }
}
