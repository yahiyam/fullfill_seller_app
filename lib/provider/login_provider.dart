// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fullfill_seller_app/authPage/auth_page.dart';
import 'package:fullfill_seller_app/mainScreens/home_screen.dart';

import '../global/global.dart';
import '../widgets/show_message_dialog.dart';

class LoginProvider extends ChangeNotifier {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<void> loginFormValidation(BuildContext context) async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      //login
      loginNow(context);
    } else {
      showMessageDialog(
        context,
        message: "Please write email/password.",
      );
    }
    notifyListeners();
  }

  Future<void> loginNow(BuildContext context) async {
    showMessageDialog(
      context,
      isLoading: true,
      message: "Checking Credentials",
    );
    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user!;
    }).catchError((error) {
      Navigator.pop(context);
      showMessageDialog(
        context,
        message: error.message.toString(),
      );
    });
    if (currentUser != null) {
      readDataAndSetDataLocally(currentUser!, context);
    }
    notifyListeners();
  }

  Future readDataAndSetDataLocally(
    User currentUser,
    BuildContext context,
  ) async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        await sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences!
            .setString("email", snapshot.data()!["sellerEmail"]);
        await sharedPreferences!
            .setString("name", snapshot.data()!["sellerName"]);
        await sharedPreferences!
            .setString("photoUrl", snapshot.data()!["sellerAvatarUrl"]);

        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
      } else {
        firebaseAuth.signOut();
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AuthPage()),
          (route) => false,
        );
        showMessageDialog(
          context,
          message: "no record exists.",
        );
      }
    });
    notifyListeners();
  }
}
