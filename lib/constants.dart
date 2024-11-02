import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';

// Colors
const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

// Gradients
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);

// Durations
const kAnimationDuration = Duration(milliseconds: 200);
const kDefaultDuration = Duration(milliseconds: 250);

// Text Styles
TextStyle headingStyle(BuildContext context) => TextStyle(
      fontSize: SizeConfig.getProportionateScreenWidth(28),
      fontWeight: FontWeight.bold,
      color: Colors.black,
      height: 1.5,
    );

// Input Decorations
InputDecoration otpInputDecoration(BuildContext context) => InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        vertical: SizeConfig.getProportionateScreenWidth(15),
      ),
      border: outlineInputBorder(context),
      focusedBorder: outlineInputBorder(context),
      enabledBorder: outlineInputBorder(context),
    );

OutlineInputBorder outlineInputBorder(BuildContext context) =>
    OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(SizeConfig.getProportionateScreenWidth(15)),
      borderSide: BorderSide(color: kTextColor),
    );

// Validators
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

// Error Messages
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNameNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String kWrongSignIn = "Wrong email or password";
const String kInvalidPhoneNumber = "Invalid phone number";
