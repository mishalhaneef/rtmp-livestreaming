import 'dart:io';

import 'package:flutter/material.dart';
import 'package:livestream/core/base_user_model.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/features/profile/application/profile_controller.dart';
import 'package:provider/provider.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({super.key, required this.user, this.isEdit = false});

  final bool isEdit;
  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Consumer<ProfileController>(
            builder: (context, value, child) {
              return GestureDetector(
                onTap: () async {
                  await value.selectImage();
                },
                child: Stack(
                  children: [
                    value.image != null
                        ? CircleAvatar(
                            radius: 50,
                            child: ClipOval(
                              child: Image.file(
                                File(value.image!.path),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(user.image ?? ''),
                          ),
                    if (isEdit)
                      const Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.camera_alt),
                        ),
                      )
                    else
                      const SizedBox()
                  ],
                ),
              );
            },
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
