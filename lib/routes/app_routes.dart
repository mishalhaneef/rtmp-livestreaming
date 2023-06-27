import 'package:flutter/material.dart';

class NavigationHandler {
  static navigateTo(BuildContext context, Widget screen) =>
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => screen),
      );

  static navigateOff(BuildContext context, Widget screen) =>
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => screen),
          (Route<dynamic> route) => false);

  static pop(context, {Stacks stacks = Stacks.singleStack}) {
    if (stacks == Stacks.twoStack) {
      Navigator.of(context)
        ..pop()
        ..pop();
    } else if (stacks == Stacks.threeStack) {
      Navigator.of(context)
        ..pop()
        ..pop()
        ..pop();
    } else {
      Navigator.pop(context);
    }
  }

  static navigateWithAnimation(BuildContext context, Widget screen,
      {required Slides slide}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = slide == Slides.slideRight
              ? const Offset(-1.0, 0.0)
              : slide == Slides.slideUp
                  ? const Offset(0.0, 1.0)
                  : slide == Slides.slideLeft
                      ? const Offset(1.0, 0.0)
                      : const Offset(0.0, 11.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}

enum Slides {
  slideUp,
  slideDown,
  slideRight,
  slideLeft,
}

enum Stacks {
  singleStack,
  twoStack,
  threeStack,
}
