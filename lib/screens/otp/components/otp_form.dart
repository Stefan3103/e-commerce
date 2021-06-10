import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import '../../../constants.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;
  List<String> pinList = [];
  String pin = "";

  @override
  void initState() async {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+38267321451',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(50),
                height: getProportionateScreenHeight(60),
                child: TextFormField(
                  inputFormatters: [new LengthLimitingTextInputFormatter(1)],
                  textAlignVertical: TextAlignVertical.top,
                  autofocus: true,
                  // obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    setState(() {
                      pin = pin + value;
                    });
                    print(pin);
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(50),
                height: getProportionateScreenHeight(60),
                child: TextFormField(
                  inputFormatters: [new LengthLimitingTextInputFormatter(1)],
                  focusNode: pin2FocusNode,
                  textAlignVertical: TextAlignVertical.top,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    setState(() {
                      pin = pin + value;
                    });
                    print(pin);
                    nextField(value, pin3FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(50),
                height: getProportionateScreenHeight(60),
                child: TextFormField(
                  inputFormatters: [new LengthLimitingTextInputFormatter(1)],
                  textAlignVertical: TextAlignVertical.top,
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    setState(() {
                      pin = pin + value;
                    });
                    print(pin);
                    nextField(value, pin4FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(50),
                height: getProportionateScreenHeight(60),
                child: TextFormField(
                  inputFormatters: [new LengthLimitingTextInputFormatter(1)],
                  textAlignVertical: TextAlignVertical.top,
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    setState(() {
                      pin = pin + value;
                    });
                    print(pin);
                    nextField(value, pin5FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(50),
                height: getProportionateScreenHeight(60),
                child: TextFormField(
                  inputFormatters: [new LengthLimitingTextInputFormatter(1)],
                  textAlignVertical: TextAlignVertical.top,
                  focusNode: pin5FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    setState(() {
                      pin = pin + value;
                    });
                    print(pin);
                    nextField(value, pin6FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(50),
                height: getProportionateScreenHeight(60),
                child: TextFormField(
                  inputFormatters: [new LengthLimitingTextInputFormatter(1)],
                  textAlignVertical: TextAlignVertical.top,
                  focusNode: pin6FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    setState(() {
                      pin = pin + value;
                    });
                    print(pin);
                    if (value.length == 1) {
                      pin6FocusNode.unfocus();
                      //Then you need to check is the code is correct or not
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "Continue",
            press: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
