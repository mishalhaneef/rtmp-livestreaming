import 'package:flutter/material.dart';
import 'package:livestream/core/base_user_model.dart';
import 'package:livestream/core/constants.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({
    super.key,
    required this.user,
  });

  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(user.image!),
          ),
          Constants.height20,
          Text(
            user.name ?? '',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          Constants.height5,
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Streamer Account',
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
    );
  }
}
