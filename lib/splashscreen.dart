import 'dart:async';
import 'package:flutter/material.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/features/authentication/presentation/login.dart';
import 'package:livestream/routes/app_routes.dart';
import 'package:livestream/widgets/splash_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 2),
      () {
        NavigationHandler.navigateOff(context, const LoginScreen());
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
}
