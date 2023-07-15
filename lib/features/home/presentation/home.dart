
import 'package:flutter/material.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/core/indicator.dart';
import 'package:livestream/features/home/application/home_controller.dart';
import 'package:livestream/features/home/presentation/widgets/fyp.dart';
import 'package:livestream/features/home/presentation/widgets/welcome_text.dart';
import 'package:provider/provider.dart';

import '../../../controller/user_base_controller.dart';
import '../../../core/user_preference_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context, listen: false);
    final streamDisplayController =
        Provider.of<StreamDisplayController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // final pref = await SharedPreferences.getInstance();
      await UserPreferenceManager.getUserDetails(userController);
      // final String? userID = pref.getString(PreferenceConstants.userID);
      await streamDisplayController.getLive();
    });
    return Scaffold(body: Consumer<UserController>(
      builder: (context, value, child) {
        if (value.isFetching || value.userModel.user == null) {
          return progressIndicator(Colors.black);
        } else {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Constants.height30,
              WelcomeText(userFullName: value.userModel.user!.name),
              Constants.height20,
              _buildFYPlabel(),
              const ForYouPage()
            ],
          );
        }
      },
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
