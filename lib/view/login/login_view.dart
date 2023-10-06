import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/color_extension.dart';
import 'package:food_delivery_app/common/extension.dart';
import 'package:food_delivery_app/common/globs.dart';
import 'package:food_delivery_app/common/service_call.dart';
import 'package:food_delivery_app/common_widget/round_button.dart';
import 'package:food_delivery_app/common_widget/round_icon_button.dart';
import 'package:food_delivery_app/common_widget/round_textfield.dart';
import 'package:food_delivery_app/view/login/reset_password_view.dart';
import 'package:food_delivery_app/view/login/sign_up_view.dart';
import 'package:food_delivery_app/view/main_tabview/main_tab_view.dart';
import 'package:food_delivery_app/view/on_boarding/on_boarding_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
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
              "Login",
              style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
            Text(
              "Add your details to login",
              style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 25,
            ),
            RoundTextField(
              hintText: "Your Email",
              controller: txtEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 20,
            ),
            RoundTextField(
              hintText: "Your Password",
              controller: txtPassword,
              obscureText: true,
            ),
            const SizedBox(
              height: 25,
            ),
            RoundButton(
                onPressed: () {
                  // use the below code when you are using an api

                  // btnLogin();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainTabView()));
                },
                title: "Login"),
            const SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ResetPasswordView()));
              },
              child: Text(
                "Forgot your password?",
                style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "or Login With",
              style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundIconButton(
              onPressed: () {},
              title: "Login with Facebook",
              icon: "assets/img/facebook_logo.png",
              color: const Color(0xff367FC0),
            ),
            const SizedBox(
              height: 25,
            ),
            RoundIconButton(
              onPressed: () {},
              title: "Login with Google",
              icon: "assets/img/google_logo.png",
              color: const Color(0xffDD4B39),
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpView()));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Don't have an Account? ",
                    style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Sign Up",
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

  // Todo: Action

  void btnLogin() {
    if (!txtEmail.text.isEmail) {
      mdShowAlert(Globs.appName, MSG.enterEmail, () {});
      return;
    }
    if (txtPassword.text.length < 6) {
      mdShowAlert(Globs.appName, MSG.enterPassword, () {});
      return;
    }
    endEditing();

    serviceCallLogin({
      "email": txtEmail.text,
      "password": txtPassword.text,
      "push_token": ""
    });
  }
  // Todo: ServiceCall

  void serviceCallLogin(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(parameter, SVKey.svLogin,
        withSuccess: (responseObj) async {
      Globs.hideHUD();
      if (responseObj[KKey.status] == "1") {
        Globs.udSet(responseObj[KKey.payload] as Map? ?? {}, Globs.userPayload);
        Globs.udBoolSet(true, Globs.userLogin);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const OnBoardingView()),
            (route) => false);
      } else {
        mdShowAlert(Globs.appName,
            responseObj[KKey.message] as String? ?? MSG.fail, () {});
      }
    }, failure: (err) async {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, err.toString(), () {});
    });
  }
}
