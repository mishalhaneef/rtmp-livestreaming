import 'package:flutter/material.dart';
import 'package:livestream/core/icons.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({
    super.key,
    this.textColor = Colors.white,
  });

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppIcon.appLogo, height: 150),
        Text(
          'VUEFLOW',
          style: TextStyle(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
