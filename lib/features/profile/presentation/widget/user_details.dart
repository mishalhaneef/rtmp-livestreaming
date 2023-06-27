import 'package:flutter/material.dart';
import 'package:livestream/core/constants.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
                'https://i.pinimg.com/736x/4a/7c/e2/4a7ce2c18eaefdcd7786cabdb724a2ba.jpg'),
          ),
          Constants.height20,
          Text(
            'Peter Parker',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          Constants.height5,
          Row(
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
