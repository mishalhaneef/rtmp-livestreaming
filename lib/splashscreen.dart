import 'dart:async';
import 'package:flutter/material.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/core/enums.dart';
import 'package:livestream/core/indicator.dart';
import 'package:livestream/features/authentication/presentation/login.dart';
import 'package:livestream/features/home/presentation/home.dart';
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
        navigateToScreen(context);
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

  void navigateToScreen(BuildContext context) {
    late Widget screen;

    switch (authStaus) {
      case AuthState.authenticated:
        screen = const HomeScreen();
        break;
      case AuthState.unauthenticated:
        screen = const LoginScreen();

        break;
      case AuthState.newUser:
        screen = const LoginScreen();

        break;
      case AuthState.sessionExpired:
        // todo: implement session expired
        break;
      case AuthState.waiting:
        progressIndicator(Palatte.theme);
        break;
      default:
        screen =
            const Placeholder(); // Default screen in case of unknown status
        break;
    }
    NavigationHandler.navigateTo(context, screen);
  }
}