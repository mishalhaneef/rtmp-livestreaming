import 'dart:async';
import 'package:flutter/material.dart';
import 'package:livestream/rootscreen.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/core/enums.dart';
import 'package:livestream/features/authentication/presentation/login.dart';
import 'package:livestream/routes/app_routes.dart';
import 'package:livestream/widgets/splash_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, required this.authStaus});

  final AuthState authStaus;

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 2),
      () {
        if (authStaus == AuthState.authenticated) {
          NavigationHandler.navigateTo(context, const RootScreen());
        } else {
          NavigationHandler.navigateTo(context, const LoginScreen());
        }
      },
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: Palatte.themeGradient),
        child: const Center(
          child: SplashLogo(),
        ),
      ),
    );
  }

  // void navigateToScreen(BuildContext context) {
  //   switch (authStaus) {
  //     case AuthState.authenticated:
  //       NavigationHandler.navigateTo(context, const RootScreen());
  //       break;
  //     case AuthState.unauthenticated:

  //       break;
  //     case AuthState.newUser:
  //       NavigationHandler.navigateTo(context, const LoginScreen());

  //       break;
  //     case AuthState.sessionExpired:
  //       // todo: implement session expired
  //       break;
  //     case AuthState.waiting:
  //       progressIndicator(Palatte.theme);
  //       break;
  //     // default:
  //     //   NavigationHandler.navigateTo(context, const Placeholder());
  //     //   break;
  //   }
  // }
}
