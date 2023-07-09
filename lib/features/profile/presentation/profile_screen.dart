import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:livestream/controller/bottom_nav_controller.dart';
import 'package:livestream/controller/user_base_controller.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/core/indicator.dart';
import 'package:livestream/core/user_preference_manager.dart';
import 'package:livestream/features/authentication/presentation/login.dart';
import 'package:livestream/features/profile/model/user_profile_items/user_profile_items.dart';
import 'package:livestream/features/profile/presentation/widget/edit_screen.dart';
import 'package:livestream/features/profile/presentation/widget/privacy_policy.dart';
import 'package:livestream/features/profile/presentation/widget/user_details.dart';
import 'package:livestream/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await UserPreferenceManager.getUserDetails(userController);
    });
    return Scaffold(
      body: Consumer<UserController>(
        builder: (context, value, child) {
          return RefreshIndicator(
            onRefresh: () async {
              await UserPreferenceManager.getUserDetails(userController);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Profile',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                ),
                Constants.height20,
                if (value.userModel.user == null)
                  progressIndicator(Colors.black)
                else
                  UserDetail(user: value.userModel.user!),
                Constants.height50,
                ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userProfileItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    final settings = userProfileItems[index];
                    return GestureDetector(
                      onTap: () async {
                        log('tapped setting : $settings');
                        if (settings == 'Edit Profile') {
                          NavigationHandler.navigateTo(
                              context, EditScreen(user: value.userModel.user!));
                        }
                        if (settings == 'Privacy Policy') {
                          NavigationHandler.navigateTo(
                              context, PrivacyPolicyScreen());
                        }
                        if (settings == 'Log out') {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Theme(
                                data: ThemeData(
                                  useMaterial3: true,
                                ),
                                child: AlertDialog(
                                  title: const Text("Log Out?"),
                                  content: const Text(
                                      "Are you sure you want to logout from vueflow?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          NavigationHandler.pop(context);
                                        },
                                        child: const Text("Cancel")),
                                    Consumer<BottomNavigationBarController>(
                                      builder: (context, value, child) =>
                                          ElevatedButton(
                                        onPressed: () async {
                                          final pref = await SharedPreferences
                                              .getInstance();
                                          await FirebaseAuth.instance.signOut();
                                          await pref.clear();
                                          if (context.mounted) {
                                            NavigationHandler.navigateTo(
                                                context, const LoginScreen());
                                          }
                                          value.changeScreen(0);
                                        },
                                        child: const Text('Logout'),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Center(
                        child: Container(
                          height: 55,
                          width: 324,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 153, 153, 153),
                                offset: Offset(4, 4),
                                blurRadius: 20,
                                spreadRadius: -10,
                              ),
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(0, 0),
                                blurRadius: 0,
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18, right: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Consumer<UserController>(
                                    builder: (context, value, child) {
                                  // if (value.userModel.user == null) {
                                  //   return progressIndicator(Colors.black);
                                  // } else {
                                  return GestureDetector(
                                    child: Text(
                                      settings,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  );
                                }
                                    // },
                                    ),
                                InkWell(
                                  onTap: () async {},
                                  child: Icon(
                                    settings == 'Log out'
                                        ? Icons.logout
                                        : Icons.keyboard_arrow_right,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 25),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
