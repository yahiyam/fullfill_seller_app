// // ignore_for_file: use_build_context_synchronously

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fullfill_seller_app/authentication/auth_screen.dart';
// import 'package:fullfill_seller_app/global/global.dart';
// import 'package:fullfill_seller_app/mainScreens/home_screen.dart';
// import 'package:fullfill_seller_app/widgets/error_dialog.dart';
// import 'package:fullfill_seller_app/widgets/loading_dialog.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   formValidation() {
//     if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
//       //login
//       loginNow();
//     } else {
//       showDialog(
//           context: context,
//           builder: (c) {
//             return const ErrorDialog(
//               message: "Please write email/password.",
//             );
//           });
//     }
//   }

//   loginNow() async {
//     showDialog(
//         context: context,
//         builder: (c) {
//           return const LoadingDialog(
//             message: "Checking Credentials",
//           );
//         });

//     User? currentUser;
//     await firebaseAuth
//         .signInWithEmailAndPassword(
//       email: emailController.text.trim(),
//       password: passwordController.text.trim(),
//     )
//         .then((auth) {
//       currentUser = auth.user!;
//     }).catchError((error) {
//       Navigator.pop(context);
//       showDialog(
//           context: context,
//           builder: (c) {
//             return ErrorDialog(
//               message: error.message.toString(),
//             );
//           });
//     });
//     if (currentUser != null) {
//       readDataAndSetDataLocally(currentUser!);
//     }
//   }

//   Future readDataAndSetDataLocally(User currentUser) async {
//     await FirebaseFirestore.instance
//         .collection("sellers")
//         .doc(currentUser.uid)
//         .get()
//         .then((snapshot) async {
//       if (snapshot.exists) {
//         await sharedPreferences!.setString("uid", currentUser.uid);
//         await sharedPreferences!
//             .setString("email", snapshot.data()!["sellerEmail"]);
//         await sharedPreferences!
//             .setString("name", snapshot.data()!["sellerName"]);
//         await sharedPreferences!
//             .setString("photoUrl", snapshot.data()!["sellerAvatarUrl"]);

//         Navigator.pop(context);
//         Navigator.push(
//             context, MaterialPageRoute(builder: (c) => const HomeScreen()));
//       } else {
//         firebaseAuth.signOut();
//         Navigator.pop(context);
//         Navigator.push(
//             context, MaterialPageRoute(builder: (c) => const AuthScreen()));

//         showDialog(
//             context: context,
//             builder: (c) {
//               return const ErrorDialog(
//                 message: "no record exists.",
//               );
//             });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Container(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//               child: Image.asset(
//                 "images/seller.png",
//                 height: 270,
//               ),
//             ),
//           ),
//           Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 CustomTextField(
//                   data: Icons.email,
//                   controller: emailController,
//                   hintText: "Email",
//                   isObsecre: false,
//                 ),
//                 CustomTextField(
//                   data: Icons.lock,
//                   controller: passwordController,
//                   hintText: "Password",
//                   isObsecre: true,
//                 ),
//               ],
//             ),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.cyan,
//               padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
//             ),
//             onPressed: () {
//               formValidation();
//             },
//             child: const Text(
//               "Login",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           const SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
// }
