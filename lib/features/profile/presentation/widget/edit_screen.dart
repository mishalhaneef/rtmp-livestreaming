import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livestream/controller/user_base_controller.dart';
import 'package:livestream/core/base_user_model.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/core/user_preference_manager.dart';
import 'package:livestream/features/profile/application/profile_controller.dart';
import 'package:livestream/features/profile/model/user_profile_items/user_profile_items.dart';
import 'package:livestream/features/profile/presentation/widget/user_details.dart';
import 'package:livestream/widgets/textfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/colors.dart';
import '../../../../core/indicator.dart';
import '../../../../widgets/custom_button.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.user});

  final UserData user;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context, listen: false);

    final profileController =
        Provider.of<ProfileController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await UserPreferenceManager.getUserDetails(userController);
      final user = userController.userModel.user!;
      profileController.usernameController.text = user.username ?? '';
      profileController.fullnameController.text = user.name ?? '';
      profileController.emailController.text = user.email ?? '';
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Constants.height20,
            UserDetail(
              user: widget.user,
              isEdit: true,
            ),
            Constants.height50,
            ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: userProfileItems.length,
              itemBuilder: (BuildContext context, int index) {
                final settings = editUserProfileItems[index];
                return GestureDetector(
                  onTap: () async {
                    final pref = await SharedPreferences.getInstance();
                    if (index == 3) {
                      await pref.clear();
                      await FirebaseAuth.instance.signOut();
                    }
                  },
                  child: Center(
                    child: Consumer<UserController>(
                        builder: (context, value, child) {
                      final user = value.userModel.user!;
                      return AppTextField(
                        suffixIcon:
                            profileController.buildSuffixIcon(Icons.edit),
                        hint: profileController.getHintText(settings, user),
                        controller: profileController.getController(settings),
                      );
                    }),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 25),
            ),
            Constants.height50,
            Center(
              child: Consumer<ProfileController>(
                builder: (context, value, child) => AppButton(
                  hintWidget:
                      value.isFetching ? progressIndicator(Colors.white) : null,
                  hint: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: value.isFetching
                      ? null
                      : () async {
                          await value.saveEditedProfileData(widget.user.id);
                        },
                  color:
                      value.isFetching ? Colors.grey : Palatte.themeGreenColor,
                ),
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
