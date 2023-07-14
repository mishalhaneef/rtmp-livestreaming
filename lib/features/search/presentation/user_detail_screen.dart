import 'package:flutter/material.dart';
import 'package:livestream/core/base_user_model.dart';
import 'package:livestream/features/profile/presentation/widget/user_details.dart';

class UserSearchDetailScreen extends StatelessWidget {
  const UserSearchDetailScreen({super.key, required this.userData});

  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          userData.name ?? '',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserDetail(user: userData),
        ],
      ),
    );
  }
}
