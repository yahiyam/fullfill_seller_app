import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fullfill_seller_app/mainScreens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';
import '../global/global.dart';
import '../widgets/show_message_dialog.dart';
import 'image_provider.dart';

class RegisterationProvider with ChangeNotifier {
  final GlobalKey<FormState> registrationFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String sellerImageUrl = '';

  Future<void> registrationFormValidation(BuildContext context) async {
    ImagesProvider imagesProvider =
        Provider.of<ImagesProvider>(context, listen: false);
    XFile? selectedImage = imagesProvider.imageXFile;

    if (selectedImage == null) {
      showMessageDialog(context, message: 'Please select an image');
    } else {
      if (passwordController.text == confirmPasswordController.text) {
        if (confirmPasswordController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            nameController.text.isNotEmpty) {
          showMessageDialog(
            context,
            isLoading: true,
            message: "Registering Account",
          );

          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          firebase_storage.Reference reference = firebase_storage
              .FirebaseStorage.instance
              .ref()
              .child("sellers")
              .child(fileName);
          firebase_storage.UploadTask uploadTask =
              reference.putFile(File(selectedImage.path));
          firebase_storage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            sellerImageUrl = url;

            //save info to firestore
            authenticateuserAndSignUp(context);
          });
        } else {
          showMessageDialog(
            context,
            message:
                "Please write the complete required info for Registration.",
          );
        }
      } else {
        showMessageDialog(
          context,
          message: "Password do not match.",
        );
      }
    }
    notifyListeners();
  }

  void authenticateuserAndSignUp(BuildContext context) async {
    User? currentUser;
    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showMessageDialog(
        context,
        message: error.message.toString(),
      );
    });

    if (currentUser != null) {
      saveDataToFirestore(currentUser!).then((value) {
        Navigator.pop(context);
        //send user to homePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      });
    }
    notifyListeners();
  }

  Future<void> saveDataToFirestore(User currentSeller) async {
    FirebaseFirestore.instance.collection("sellers").doc(currentSeller.uid).set({
      "sellerUID": currentSeller.uid,
      "sellerEmail": currentSeller.email,
      "sellerName": nameController.text.trim(),
      "sellerAvatarUrl": sellerImageUrl,
      "status": "approved",
    });

    //save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentSeller.uid);
    await sharedPreferences!.setString("email", currentSeller.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoUrl", sellerImageUrl);
    notifyListeners();
  }
}
