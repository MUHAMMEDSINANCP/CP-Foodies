// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common_widget/round_button.dart';
import 'package:food_delivery_app/common_widget/round_textfield.dart';
import 'package:food_delivery_app/view/on_boarding/startup_view.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/color_extension.dart';
import '../more/my_order_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  String userName = "";
  bool isLoading = false; // Add this variable to track loading state
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        userName = userSnapshot['name'];
        txtName = TextEditingController(text: userSnapshot['name']);
        txtEmail = TextEditingController(text: user.email);
        txtMobile = TextEditingController(text: userSnapshot['mobile']);
        txtAddress = TextEditingController(text: userSnapshot['address']);
      });
    }
  }

  void _updatePassword() async {
    User? user = FirebaseAuth.instance.currentUser;

    try {
      await user!.updatePassword(txtPassword.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password updated successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update password. Please try again.'),
        ),
      );
    }
  }

  void _updateUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'name': txtName.text.trim(),
          'email': txtEmail.text.trim(),
          'mobile': txtMobile.text.trim(),
          'address': txtAddress.text.trim(),
          // Add other fields you want to update here
        });

        // Update the local state to reflect the changes
        setState(() {
          userName = txtName.text.trim();
          // Update other controllers if needed
        });

        // Show a confirmation to the user about the update
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Details updated successfully'),
          ),
        );
      } catch (e) {
        print('Error updating user details: $e');
        // Show an error message to the user if the update fails
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update details. Please try again.'),
          ),
        );
      }
    }
  }

  void _showSignOutConfirmationDialog() {
    print('Sign Out button pressed'); // Add this line for debugging

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            'Sign Out',
            style: TextStyle(color: TColor.primary),
          )),
          content: const Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                // Implement sign-out logic here
                // For example:
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StartupView()));
              },
              child: const Text(
                'Sign Out',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyOrderView()));
                      },
                      icon: Image.asset(
                        "assets/img/shopping_cart.png",
                        height: 25,
                        width: 25,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: TColor.placeholder,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          File(image!.path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 65,
                        color: TColor.secondaryText,
                      ),
              ),
              TextButton.icon(
                onPressed: () async {
                  image = await picker.pickImage(source: ImageSource.gallery);
                  setState(() {});
                },
                icon: Icon(
                  Icons.edit,
                  color: TColor.primary,
                  size: 12,
                ),
                label: Text(
                  "Edit Profile",
                  style: TextStyle(color: TColor.primary, fontSize: 14),
                ),
              ),
              Text(
                userName,
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: _showSignOutConfirmationDialog,
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(3, 2))
                      ],
                      color: TColor.primary,
                      borderRadius: BorderRadius.circular(16)),
                  width: 70,
                  height: 22,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 9, top: 3),
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                          color: TColor.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: RoundedTitleTextField(
                  hintText: "Enter Name",
                  title: "Name",
                  controller: txtName,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: RoundedTitleTextField(
                  hintText: "Enter Email",
                  title: "Email",
                  controller: txtEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: RoundedTitleTextField(
                  hintText: "Enter Mobile No.",
                  title: "Mobile No.",
                  controller: txtMobile,
                  keyboardType: TextInputType.phone,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: RoundedTitleTextField(
                  hintText: "Enter Address",
                  title: "Address",
                  controller: txtAddress,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: RoundedTitleTextField(
                  hintText: "Create new Password",
                   controller: txtPassword,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    child: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: isPasswordVisible ? TColor.primary : Colors.grey,
                    ),
                  ),
                  obscureText: !isPasswordVisible,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: RoundedTitleTextField(
                  hintText: "Confirm new Password",
                   controller: txtConfirmPassword,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                    child: Icon(
                      isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: isConfirmPasswordVisible
                          ? TColor.primary
                          : Colors.grey,
                    ),
                  ),
                  obscureText: !isConfirmPasswordVisible,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: RoundButton(
                    onPressed: () {
                      if (txtPassword.text.isNotEmpty &&
                          txtPassword.text == txtConfirmPassword.text) {
                        _updatePassword();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Passwords do not match.'),
                          ),
                        );
                      }
                    },
                    title: "Save",
                    isLoading: isLoading),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
