import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  User loggedInUser;
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email + " " + loggedInUser.uid);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();

    super.initState();
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                try {
                  _fireStore
                      .collection("user information")
                      .doc("${loggedInUser.uid}")
                      .set({
                    "first name": firstName,
                    "last name": lastName,
                    "address": address,
                    "phone number": phoneNumber,
                  });
                  Navigator.pushNamed(context, OtpScreen.routeName);
                } catch (e) {
                  print(e);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your phone address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  InternationalPhoneNumberInput buildPhoneNumberFormField() {
    return InternationalPhoneNumberInput(
      onInputChanged: (value) {
        print(value);
        setState(() {
          phoneNumber = value.phoneNumber;
        });
      },
      onInputValidated: (value) {
        print(value);
        if (value == false) {
          addError(error: kInvalidPhoneNumber);
        } else if (value == true) {
          removeError(error: kInvalidPhoneNumber);
        }
      },
      inputDecoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
      initialValue: PhoneNumber(isoCode: "ME"),
      countries: ["RS", "ME", "BA", "HR", "SI", "MK", "AL"],
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}

// return TextFormField(
//   keyboardType: TextInputType.phone,
//   onSaved: (newValue) => phoneNumber = newValue,
//   onChanged: (value) {
//     if (value.isNotEmpty) {
//       removeError(error: kPhoneNumberNullError);
//     }
//     return null;
//   },
//   validator: (value) {
//     if (value.isEmpty) {
//       addError(error: kPhoneNumberNullError);
//       return "";
//     }
//     return null;
//   },
//   decoration: InputDecoration(
//     labelText: "Phone Number",
//     hintText: "Enter your phone number",
//     // If  you are using latest version of flutter then lable text and hint text shown like this
//     // if you r using flutter less then 1.20.* then maybe this is not working properly
//     floatingLabelBehavior: FloatingLabelBehavior.always,
//     suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
//   ),
// );
