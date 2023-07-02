import 'package:flutter/material.dart';
import 'package:livestream/core/base_user_model.dart';
import 'package:livestream/core/constants.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({super.key, required this.user, this.isEdit = false});

  final bool isEdit;
  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 55,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(user.image!),
              ),
              isEdit
                  ? const Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.camera_alt),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
          Constants.height20,
          Text(
            user.name ?? '',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          Constants.height5,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.username ?? '',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 5),
              const Icon(
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
