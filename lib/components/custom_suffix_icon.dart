import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class CustomSuffixIcon extends StatelessWidget {
  const CustomSuffixIcon({
    Key? key,
    required this.svgIcon,
  }) : super(key: key);

  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        SizeConfig.getProportionateScreenWidth(20),
        SizeConfig.getProportionateScreenWidth(20),
        SizeConfig.getProportionateScreenWidth(20),
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: SizeConfig.getProportionateScreenWidth(18),
        colorFilter: ColorFilter.mode(
          Theme.of(context).iconTheme.color ?? Colors.black,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
