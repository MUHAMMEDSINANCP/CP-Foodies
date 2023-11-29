import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/color_extension.dart';
import 'package:food_delivery_app/common_widget/round_button.dart';
import 'package:food_delivery_app/common_widget/round_textfield.dart';
import 'package:food_delivery_app/view/login/login_view.dart';
import 'package:food_delivery_app/view/main_tabview/main_tab_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _LoginViewState();
}

class _LoginViewState extends State<SignUpView> {
  String name = "";
  String email = "";
  String mobile = "";
  String address = "";
  String password = "";
  String confirmPassword = "";

  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  final GlobalKey<FormState> _formkeysignup = GlobalKey<FormState>();

  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  bool isStay = false;

  Future<void> register() async {
    if (txtName.text.isEmpty ||
        txtPassword.text.isEmpty ||
        txtEmail.text.isEmpty ||
        txtAddress.text.isEmpty ||
        txtConfirmPassword.text.isEmpty ||
        txtMobile.text.isEmpty) {
      showSnackBar(
        context,
        "Please fill in all fields...!",
      );
    }
    if (txtPassword.text != txtConfirmPassword.text) {
      showSnackBar(context, "Passwords do not match");
      return; // Exit the function if passwords don't match
    }

    try {
      setState(() {
        isLoading = true;
      });

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(password: password, email: email);

      // Save user details including name to Firebase or your database
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'email': email,
        'address': address,

        'mobile': mobile,

        // Add other user details if needed
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
            backgroundColor: TColor.primary,
            content: const Text(
              "Registered Successfully",
              style: TextStyle(
                fontSize: 20,
              ),
            ))));
      }
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainTabView()));
      }
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'weak-password':
          if (context.mounted) {
            showSnackBar(context, "Password provided is too weak");
          }
          break;
        case 'email-already-in-use':
          if (context.mounted) {
            showSnackBar(context, "Account already exists!");
          }
          break;
        case 'invalid-email':
          if (context.mounted) {
            showSnackBar(context, " email address is not valid.");
          }
          break;
        case 'operation-not-allowed':
          if (context.mounted) {
            showSnackBar(context,
                "Enable email/password accounts in the Firebase Console, under the Auth tab.");
          }

        default:
          // Handle other FirebaseException codes here
          break;
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // var media = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Form(
          key: _formkeysignup,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name.";
                  }
                  return null;
                },
                hintText: "Name",
                controller: txtName,
              ),
              const SizedBox(
                height: 25,
              ),
              RoundTextField(
                hintText: "Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email.";
                  }
                  return null;
                },
                controller: txtEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 25,
              ),
              RoundTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a mobile number.";
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Home Address.";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              RoundTextField(
                hintText: "Password",
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: isPasswordVisible ? TColor.primary : Colors.grey,
                    ),
                  ),
                ),
                controller: txtPassword,
                obscureText: !isPasswordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Create a password.";
                  }
                  if (value != txtConfirmPassword.text) {
                    return "Passwords don't match";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              RoundTextField(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isConfirmPasswordVisible = !isConfirmPasswordVisible;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: Icon(
                      isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: isConfirmPasswordVisible
                          ? TColor.primary
                          : Colors.grey,
                    ),
                  ),
                ),
                hintText: "Confirm your password.",
                controller: txtConfirmPassword,
                obscureText: !isConfirmPasswordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Confirm your password.";
                  }
                  if (value != txtPassword.text) {
                    return "Passwords don't match";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              RoundButton(
                  isLoading: isLoading,
                  onPressed: () async {
                    if (_formkeysignup.currentState!.validate()) {
                      setState(() {
                        email = txtEmail.text.trim();
                        password = txtPassword.text.trim();
                        name = txtName.text.trim();
                        address = txtAddress.text.trim();
                        mobile = txtMobile.text.trim();
                      });
                    }
                    register();
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginView()));
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
        ),
      )),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.width * 1.91,
          left: 20,
          right: 20),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.redAccent,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    ),
  );
}
