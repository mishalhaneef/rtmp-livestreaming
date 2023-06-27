import 'package:flutter/material.dart';
import 'package:livestream/core/colors.dart';
import '../../../../core/constants.dart';

class MessageThread extends StatelessWidget {
  const MessageThread({
    super.key,
    required this.message,
    required this.time,
    required this.isMe,
    this.readed = false,
    this.limitReached = false,
  });

  final String message;
  final String time;
  final bool isMe;
  final bool readed;
  final bool limitReached;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMe
          ? const EdgeInsets.only(right: 30, top: 10, bottom: 10, left: 100)
          : const EdgeInsets.only(left: 30, top: 10, bottom: 10, right: 100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.center,
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isMe ? Palatte.theme : Palatte.themeGreenColor,
                  borderRadius: isMe
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        )
                      : const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              // if (limitReached)
              //   if (!isMe)
              //     Row(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.all(18.0),
              //           child: Stack(
              //             children: [
              //               Text(
              //                 message,
              //                 style:
              //                     TextStyle(color: isMe ? Colors.white : null),
              //               ),
              //               BackdropFilter(
              //                 filter: ui.ImageFilter.blur(
              //                   sigmaX: 4,
              //                   sigmaY: 2,
              //                 ),
              //                 child: const SizedBox(),
              //               ),
              //             ],
              //           ),
              //         ),
              //         _buildInfoButton(context),
              //       ],
              //     )
            ],
          ),
          Constants.height10,
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Text(
                time,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 5),
              if (isMe)
                if (readed)
                  const Icon(
                    Icons.done_all,
                    color: Colors.blue,
                    size: 20,
                  )
            ],
          )
        ],
      ),
    );
  }
}
