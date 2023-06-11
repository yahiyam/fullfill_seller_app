import 'package:flutter/material.dart';
import 'package:fullfill_seller_app/global/colors.dart';
import 'package:provider/provider.dart';

import '../../provider/login_provider.dart';
import '../../widgets/common_button.dart';
import '../widgets/custom_text_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: screen.height/8),
      child: Consumer<LoginProvider>(builder: (context, loginProvider, _) {
        return Form(
          key: loginProvider.loginFormKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screen.width / 10),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: loginProvider.emailController,
                      labelText: 'Email address',
                      icon: Icons.alternate_email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: screen.height / 70),
                    CustomTextField(
                      controller: loginProvider.passwordController,
                      obscureText: true,
                      labelText: 'Password',
                      icon: Icons.password_rounded,
                      showSuffixIcon: true,
                    ),
                    SizedBox(height: screen.height / 70),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Passcode?',
                          style: TextStyle(
                            color: forgotPasswordColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screen.height / 70),
                  ],
                ),
              ),
              CommonButton(
                title: 'Login',
                onTap: () {
                  loginProvider.loginFormValidation(context);
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
