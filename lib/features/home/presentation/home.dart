import 'package:flutter/material.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/features/home/presentation/widgets/fyp.dart';
import 'package:livestream/features/home/presentation/widgets/welcome_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const WelcomeText(),
        Constants.height20,
        // const AppTextField(
        //   hint: 'Search...',
        //   suffixIcon: Padding(
        //     padding: EdgeInsets.only(right: 10),
        //     child: Icon(Icons.search),
        //   ),
        // ),
        // Constants.height30,
        _buildFYPlabel(),
        const ForYouPage()
      ],
    ));
  }

  Padding _buildFYPlabel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
      child: Row(
        children: [
          const Text(
            'For You',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
                color: Palatte.red.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
              child: Text(
                'LIVE',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
