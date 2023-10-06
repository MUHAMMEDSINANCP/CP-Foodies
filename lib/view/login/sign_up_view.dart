import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/color_extension.dart';
import 'package:food_delivery_app/common_widget/round_button.dart';
import 'package:food_delivery_app/common_widget/round_textfield.dart';
import 'package:food_delivery_app/view/login/login_view.dart';
import 'package:food_delivery_app/view/login/otp_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _LoginViewState();
}

class _LoginViewState extends State<SignUpView> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 64,
            ),
            Text(
              "Sign Up",
              style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
            Text(
              "Add your details to Sign Up",
              style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 25,
            ),
            RoundTextField(
              hintText: "Name",
              controller: txtName,
            ),
            const SizedBox(
              height: 25,
            ),
            RoundTextField(
              hintText: "Email",
              controller: txtEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 25,
            ),
            RoundTextField(
              hintText: "Mobile No.",
              controller: txtMobile,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(
              height: 25,
            ),
            RoundTextField(
              hintText: "Address",
              controller: txtAddress,
            ),
            const SizedBox(
              height: 25,
            ),
            RoundTextField(
              hintText: "Password",
              controller: txtPassword,
              obscureText: true,
            ),
            const SizedBox(
              height: 25,
            ),
            RoundTextField(
              hintText: "Confirm Password",
              controller: txtConfirmPassword,
              obscureText: true,
            ),
            const SizedBox(
              height: 25,
            ),
            RoundButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const OTPView()));
                },
                title: "Sign Up"),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginView()));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Already have an Account? ",
                    style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                        color: TColor.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
