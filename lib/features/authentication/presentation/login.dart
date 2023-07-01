import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/features/authentication/application/authentication_controller.dart';
import 'package:livestream/features/authentication/presentation/registration.dart';
import 'package:livestream/routes/app_routes.dart';
import 'package:livestream/widgets/custom_button.dart';
import 'package:livestream/widgets/textfield.dart';
import 'package:livestream/widgets/splash_logo.dart';
import 'package:provider/provider.dart';

import '../../../rootscreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController =
        Provider.of<AuthenticationController>(context, listen: false);

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
          // AppTextField(
          //   controller: authController.usernameController,
          //   hint: 'username',
          // ),
          Constants.height50,
          AppTextField(
            controller: authController.emailController,
            hint: 'Email',
          ),
          Constants.height30,
          AppTextField(
            controller: authController.passwordController,
            hint: 'Password',
          ),
          Constants.height20,
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Don't have an account yet?  "),
                GestureDetector(
                  onTap: () async {
                    NavigationHandler.navigateOff(
                        context, const RegistrationScreen());
                  },
                  child: const Text(
                    'Register',
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
          Consumer<AuthenticationController>(
            builder: (context, value, child) => AppButton(
              hint: const Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () async {
                final email = value.emailController.text;
                final password = value.passwordController.text;
                if (email.isEmpty) {
                  Fluttertoast.showToast(msg: "Enter Email");
                } else if (password.isEmpty) {
                  Fluttertoast.showToast(msg: "Enter password");
                } else {
                  bool authenticated =
                      await value.loginWIthEmailAndPassword(email, password);

                  if (authenticated) {
                    if (context.mounted) {
                      NavigationHandler.navigateOff(
                          context, const RootScreen());
                    }
                  }
                }
              },
              color: Palatte.themeGreenColor,
            ),
          ),
          Constants.height50,
          Constants.height50,
        ],
      ),
    );
  }
}
