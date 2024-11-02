import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';

class CustomAppBar extends PreferredSize {
  final double rating;

  CustomAppBar({Key? key, required this.rating})
      : super(
          key: key,
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: _CustomAppBarContent(rating: rating),
        );
}

class _CustomAppBarContent extends StatelessWidget {
  final double rating;

  const _CustomAppBarContent({Key? key, required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.getProportionateScreenWidth(20)),
        child: Row(
          children: [
            SizedBox(
              height: SizeConfig.getProportionateScreenWidth(40),
              width: SizeConfig.getProportionateScreenWidth(40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  elevation: 0,
                ),
                onPressed: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 15,
                ),
              ),
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Text(
                    "$rating",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset("assets/icons/Star Icon.svg"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
