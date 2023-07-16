import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:livestream/controller/bottom_nav_controller.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/core/icons.dart';
import 'package:livestream/features/home/presentation/home.dart';
import 'package:livestream/features/live_setup/application/live_setup_controller.dart';
import 'package:livestream/features/live_setup/presentation/live_setup_screen.dart';
import 'package:livestream/features/profile/presentation/profile_screen.dart';
import 'package:livestream/features/search/presentation/search.dart';
import 'package:livestream/routes/app_routes.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      // const ChatScreen(),
      const LiveSetupScreen(),
      const SearchScreen(),
      const ProfileScreen(),
    ];

    return Consumer<BottomNavigationBarController>(
      builder: (context, value, child) => Scaffold(
        body: Scaffold(
          // appBar: PreferredSize(
          //   preferredSize: const Size.fromHeight(20),
          //   child: AppBar(
          //     backgroundColor: Colors.grey[50],
          //     elevation: 0,
          //   ),
          // ),
          body: pages[value.currentIndex],
        ),
        bottomNavigationBar: _bottomNavigationBar(value, context),
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar(
      BottomNavigationBarController value, BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        log("Current index : ${value.currentIndex}");
        if (index == 1) {
          NavigationHandler.navigateTo(context, const LiveSetupScreen());
        } else {
          value.changeScreen(index);
        }
      },
      currentIndex: value.currentIndex,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          activeIcon: _activeIcon(BottomNavIcons.home),
          icon: _inActiveIcon(BottomNavIcons.unselectedhome),
          label: '',
        ),
        // BottomNavigationBarItem(
        //   activeIcon: _activeIcon(BottomNavIcons.chats),
        //   icon: _inActiveIcon(BottomNavIcons.unselectedchats),
        //   label: '',
        // ),
        BottomNavigationBarItem(
          activeIcon: _activeIcon(BottomNavIcons.goLive, height: 50),
          icon: _inActiveIcon(BottomNavIcons.unselectedgoLive, height: 50),
          label: '',
        ),
        BottomNavigationBarItem(
          activeIcon: _activeIcon(BottomNavIcons.search),
          icon: _inActiveIcon(BottomNavIcons.unselectedsearch),
          label: '',
        ),
        BottomNavigationBarItem(
          activeIcon: _activeIcon(BottomNavIcons.profile),
          icon: _inActiveIcon(BottomNavIcons.unselectedprofile),
          label: '',
        ),
      ],
    );
  }

  Image _inActiveIcon(icon, {double height = 30}) => Image.asset(
        icon,
        height: height,
      );

  Image _activeIcon(icon, {double height = 30}) =>
      Image.asset(icon, color: Palatte.theme, height: height);
}

void showLeaveStreamConfirmationDialog(
  BuildContext context,
  BottomNavigationBarController value,
  int targetIndex,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
            'Leaving the streaming screen will stop the live stream.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          Consumer<LiveController>(
            builder: (context, liveController, child) => TextButton(
              onPressed: () async {
                value.changeScreen(targetIndex);
                Navigator.of(context).pop();
                liveController.onStopStreamingButtonPressed();
                await liveController.stopStreaming();
                await liveController.setStream(false);
              },
              child: const Text('Leave'),
            ),
          ),
        ],
      );
    },
  );
}
