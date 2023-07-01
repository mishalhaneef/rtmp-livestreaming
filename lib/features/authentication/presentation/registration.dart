import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:livestream/rootscreen.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/features/authentication/application/authentication_controller.dart';
import 'package:livestream/features/authentication/presentation/login.dart';
import 'package:livestream/routes/app_routes.dart';
import 'package:livestream/widgets/custom_button.dart';
import 'package:livestream/widgets/textfield.dart';
import 'package:livestream/widgets/splash_logo.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

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
          AppTextField(
            hint: 'Full Name',
            controller: authController.nameController,
          ),
          Constants.height30,
          AppTextField(
            hint: 'Username',
            controller: authController.usernameController,
          ),
          Constants.height30,
          AppTextField(
            hint: 'Email',
            controller: authController.emailController,
          ),
          Constants.height30,
          AppTextField(
            hint: 'Password',
            controller: authController.passwordController,
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
          Consumer<AuthenticationController>(
            builder: (context, value, child) => AppButton(
              hint: const Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () async {
                final username = value.usernameController.text;
                final fullName = value.nameController.text;
                final email = value.emailController.text;
                final password = value.passwordController.text;
                if (password.isEmpty) {
                  Fluttertoast.showToast(msg: 'Enter Password');
                } else if (fullName.isEmpty) {
                  Fluttertoast.showToast(msg: 'Enter Full Name');
                } else if (email.isEmpty) {
                  Fluttertoast.showToast(msg: 'Enter Email');
                } else {
                  bool authenticated = await value.registerWithEmailAndPassword(
                    username,
                    fullName,
                    email,
                    password,
                  );
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
