import 'package:flutter/material.dart';

import '../core/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.hint,
    this.onTap,
    this.color = Palatte.red,
    this.shadows = true,
    this.hintWidget,
  });

  final Widget hint;
  final Function()? onTap;
  final Color color;
  final bool shadows;
  final Widget? hintWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        width: 270,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            boxShadow: shadows
                ? const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(-4, -4),
                      blurRadius: 50,
                      spreadRadius: -20,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0, 0),
                      blurRadius: 0,
                      spreadRadius: 0,
                    )
                  ]
                : null),
        child: hintWidget ?? Center(child: hint),
      ),
    );
  }
}
