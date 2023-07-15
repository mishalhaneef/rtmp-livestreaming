import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/core/icons.dart';
import 'package:livestream/features/authentication/application/authentication_controller.dart';
import 'package:livestream/features/authentication/presentation/registration.dart';
import 'package:livestream/rootscreen.dart';
import 'package:livestream/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../../core/indicator.dart';
import '../../../routes/app_routes.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key, this.passwordResetting = false});

  final bool passwordResetting;

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  void initState() {
    Provider.of<AuthenticationController>(context, listen: false)
        .emailVerificationChecking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userEmail = currentUser!.email;
    // String email = authProvider.userData!.email;
    // String hiddenEmail =
    //     email.replaceAll(RegExp(r'(?<=.{3}).(?=[^@]*?@)'), '*');

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(),
      body: Consumer<AuthenticationController>(
        builder: (context, value, child) => ListView(
          physics: const BouncingScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Image.network(
                AppImages.emailVerification,
                height: size.height / 2 - 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email Verification",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Constants.height10,
                  Text(
                    'an Email verification link has been sent to $userEmail',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Constants.height40,
            const SizedBox(height: 60),
            Consumer<AuthenticationController>(
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: AppButton(
                  color: Palatte.theme,
                  hint: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                  hintWidget: !value.isEmailVerified
                      ? progressIndicator(Colors.white)
                      : null,
                  onTap: value.isEmailVerified
                      ? () {
                          NavigationHandler.navigateOff(
                            context,
                            const RootScreen(),
                          );
                        }
                      : () {},
                ),
              ),
            ),
            Constants.height30,
            if (!value.isEmailVerified)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await value.resendVerificationLink();
                    },
                    child: const Text(
                      "Resend Verification Link",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            Constants.height40,
            if (!value.isEmailVerified)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Wrong email ?  ",
                    style: TextStyle(),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (FirebaseAuth.instance.currentUser != null) {
                        await FirebaseAuth.instance.currentUser!.delete();
                      }
                      await FirebaseAuth.instance.signOut();

                      if (context.mounted) {
                        NavigationHandler.navigateOff(
                            context, const RegistrationScreen());
                      }
                      Fluttertoast.showToast(
                          msg: 'Register Again with Valid Email');
                    },
                    child: const Text(
                      "Click Here to Change",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
