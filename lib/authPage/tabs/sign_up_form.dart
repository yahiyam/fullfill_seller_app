import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global/colors.dart';
import '../../provider/auth_page_tabs_provider.dart';
import '../../provider/image_provider.dart';
import '../../provider/registeration_provider.dart';
import '../../widgets/common_button.dart';
import '../widgets/custom_text_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final tabProvider = Provider.of<AuthTabsProvider>(context);

    return SingleChildScrollView(
      child: Consumer<RegisterationProvider>(
        builder: (context, registerationProvider, _) {
          return Column(
            children: [
              SizedBox(height: screen.height / 70),
              Consumer<ImagesProvider>(
                builder: (context, imageProvider, _) => InkWell(
                  onTap: () => imageProvider.pickImage(),
                  child: CircleAvatar(
                    radius: screen.width * 0.20,
                    backgroundColor: white,
                    backgroundImage: imageProvider.imageXFile == null
                        ? null
                        : FileImage(File(imageProvider.imageXFile!.path)),
                    child: imageProvider.imageXFile == null
                        ? Icon(
                            Icons.add_photo_alternate,
                            size: screen.width * 0.20,
                            color: grey,
                          )
                        : null,
                  ),
                ),
              ),
              SizedBox(height: screen.height / 70),
              Form(
                key: registerationProvider.registrationFormKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screen.width / 10),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: registerationProvider.nameController,
                        icon: Icons.person,
                        labelText: 'Name',
                      ),
                      SizedBox(height: screen.height / 70),
                      CustomTextField(
                        controller: registerationProvider.emailController,
                        icon: Icons.alternate_email,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: screen.height / 70),
                      CustomTextField(
                        controller: registerationProvider.passwordController,
                        icon: Icons.password,
                        labelText: 'Password',
                        obscureText: true,
                        showSuffixIcon: true,
                      ),
                      SizedBox(height: screen.height / 70),
                      CustomTextField(
                        controller:
                            registerationProvider.confirmPasswordController,
                        icon: Icons.password,
                        labelText: 'Confirm Password',
                        obscureText: true,
                      ),
                      SizedBox(height: screen.height / 70),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            const Text('Already have an account?'),
                            TextButton(
                              onPressed: () {
                                tabProvider.changeTab(0);
                              },
                              child: const Text(
                                'Log in',
                                style: TextStyle(
                                  color: alreadyHaveAccountColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screen.height / 70),
              CommonButton(
                title: "Sign Up",
                onTap: () {
                  registerationProvider.registrationFormValidation(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
