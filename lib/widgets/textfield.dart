
import 'package:flutter/material.dart';
import 'package:livestream/features/chats/application/chat_controller.dart';
import 'package:provider/provider.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      required this.hint,
      this.suffixIcon,
      this.height = 55,
      this.width = 324,
      this.controller,
      this.chat = false,
      this.onChanged});

  final String hint;
  final Widget? suffixIcon;
  final double height;
  final double width;
  final TextEditingController? controller;
  final bool chat;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(-4, -4),
              blurRadius: 50,
              spreadRadius: -20,
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
          padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    suffixIcon: suffixIcon,
                  ),
                  onChanged: onChanged,
                ),
              ),
              chat
                  ? Consumer<ChatProvider>(
                      builder: (context, value, child) => IconButton(
                          onPressed: () {
                            value.handleSendMessage(value.textController.text);
                          },
                          icon: const Icon(
                            Icons.near_me,
                            color: Colors.black,
                          )),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
