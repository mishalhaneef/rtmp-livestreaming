import 'package:flutter/material.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/features/live_setup/application/live_setup_controller.dart';
import 'package:livestream/widgets/textfield.dart';
import 'package:provider/provider.dart';

import '../../../core/constants.dart';
import '../../../widgets/custom_button.dart';

class LiveSetupScreen extends StatelessWidget {
  const LiveSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Padding(
        //   padding: EdgeInsets.only(left: 20),
        //   child: Text(
        //     'Stream Setup',
        //     style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
        //   ),
        // ),
        Constants.height30,
        _buildUserDetails(),
        Constants.height50,
        const AppTextField(
          hint: 'Stream Title',
          suffixIcon: Icon(Icons.title),
        ),
        Constants.height30,
        AppTextField(
          hint: 'Enable Comments',
          suffixIcon: Consumer<LiveController>(
            builder: (context, value, child) => Switch(
              value: value.isSwitch,
              onChanged: (val) {
                value.onButtonEnables(val);
              },
              activeColor: Colors.black,
            ),
          ),
        ),
        const Spacer(),
        Center(
          child: Consumer<LiveController>(
            builder: (context, value, child) => AppButton(
              shadows: false,
              color:
                  value.goingLive ? Palatte.red.withOpacity(0.5) : Palatte.red,
              hint: value.goingLive
                  ? const SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : const Text(
                      'GO LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              onTap: () {
                value.onGoLive();
              },
            ),
          ),
        ),
        Constants.height50,
      ],
    ));
  }

  Padding _buildUserDetails() {
    return const Padding(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
                'https://i.pinimg.com/736x/4a/7c/e2/4a7ce2c18eaefdcd7786cabdb724a2ba.jpg'),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Peter Parker',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              Constants.height5,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'peter_parker098',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 15,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
