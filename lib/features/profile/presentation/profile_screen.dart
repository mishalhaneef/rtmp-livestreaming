import 'package:flutter/material.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/features/profile/model/user_profile_items/user_profile_items.dart';
import 'package:livestream/features/profile/presentation/widget/user_details.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          const UserDetail(),
          Constants.height50,
          ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: userProfileItems.length,
            itemBuilder: (BuildContext context, int index) {
              final user = userProfileItems[index];
              return Center(
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
                        Text(
                          user,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Icon(
                          user == 'Log out'
                              ? Icons.logout
                              : Icons.keyboard_arrow_right,
                          size: 25,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 25),
          ),
        ],
      ),
    );
  }
}
