import 'package:flutter/material.dart';
import 'package:livestream/core/base_user_model.dart';
import 'package:livestream/core/constants.dart';
import 'package:provider/provider.dart';

import '../../application/profile_controller.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({super.key, required this.user, this.isEdit = false});

  final bool isEdit; 
  final UserData user;

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  // File? _image;
  // Future<void> _selectImage() async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedImage != null) {
  //     setState(() {
  //       _image = File(pickedImage.path);
  //     });

  // final bytes = await _image!.readAsBytes();
  // final base64Image = base64Encode(bytes);

  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('thumbnail', base64Image);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final profileController =
        Provider.of<ProfileController>(context, listen: false);

    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              profileController.image != null
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(profileController.image!),
                    )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          profileController
                              .saveEditedProfileData(widget.user.id);
                        });
                        print('click');
                      },
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(widget.user.image!),
                      ),
                    ),
              widget.isEdit
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
            widget.user.name ?? '',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          Constants.height5,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.user.username ?? '',
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
