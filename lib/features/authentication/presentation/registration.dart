import 'package:flutter/material.dart';

import 'package:livestream/bottom_nav.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/features/authentication/presentation/login.dart';
import 'package:livestream/routes/app_routes.dart';
import 'package:livestream/widgets/custom_button.dart';
import 'package:livestream/widgets/textfield.dart';
import 'package:livestream/widgets/splash_logo.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Constants.height50,
          Constants.height50,
          const SplashLogo(
            textColor: Colors.black,
          ),
          Constants.height50,
          const AppTextField(
            hint: 'Full Name',
          ),
          Constants.height30,
          const AppTextField(
            hint: 'Username',
          ),
          Constants.height30,
          const AppTextField(
            hint: 'Email',
          ),
          Constants.height30,
          const AppTextField(
            hint: 'Password',
          ),
          Constants.height30,
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Already have an account?  "),
                GestureDetector(
                  onTap: () {
                    NavigationHandler.navigateOff(context, const LoginScreen());
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue),
                  ),
                ),
                const SizedBox(width: 50)
              ],
            ),
          ),
          const Spacer(),
          AppButton(
            hint: const Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              NavigationHandler.navigateOff(context, const RootScreen());
            },
            color: Palatte.themeGreenColor,
          ),
          Constants.height50,
          Constants.height50,
        ],
      ),
    );
  }
}
