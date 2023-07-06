import 'package:flutter/material.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/core/indicator.dart';
import 'package:livestream/features/home/model/stream_model.dart';
import 'package:livestream/features/live_chats/application/live_chat_controller.dart';
import 'package:livestream/features/live_view/application/live_view_controller.dart';
import 'package:provider/provider.dart';

import '../../live_view/presentation/live_view_appbar.dart';

class LiveChat extends StatelessWidget {
  const LiveChat({
    super.key,
    required this.streamer,
  });

  final Live streamer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Constants.height50,
        LiveViewAppBar(streamer: streamer),
        const Spacer(),
        Consumer<LiveChatController>(
          builder: (context, value, child) {
            if (value.message == null) {
              return progressIndicator(Colors.black);
            } else {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(28.0),
                reverse: true,
                shrinkWrap: true,
                itemCount: value.totalCount < 5 ? value.totalCount : 5,
                itemBuilder: (context, inde3x) {
                  // if (data.isDonation) {
                  //   return Opacity(
                  //     opacity: index >= 3 ? 0.4 : 1,
                  //     child: Row(
                  //       children: [
                  //         const CircleAvatar(
                  //           maxRadius: 20,
                  //           backgroundImage: NetworkImage(
                  //               'https://i.pinimg.com/736x/4a/7c/e2/4a7ce2c18eaefdcd7786cabdb724a2ba.jpg'),
                  //         ),
                  //         const SizedBox(width: 10),
                  //         Container(
                  //           decoration: BoxDecoration(
                  //               color: Colors.white.withOpacity(0.2),
                  //               borderRadius: BorderRadius.circular(8)),
                  //           child: Padding(
                  //             padding: EdgeInsets.all(5.0),
                  //             child: Row(
                  //               children: [
                  //                 const Text(
                  //                   'Peter Parker Gifted  ',
                  //                   style: TextStyle(
                  //                     color: Color.fromARGB(255, 193, 193, 193),
                  //                   ),
                  //                 ),
                  //                 Text(
                  //                   '${data.message}\$ !!!',
                  //                   style: const TextStyle(
                  //                       color: Colors.white,
                  //                       fontWeight: FontWeight.bold),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   );
                  // } else {
                  return Opacity(
                    opacity: value.totalCount >= 3 ? 0.4 : 1,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          maxRadius: 20,
                          backgroundImage: NetworkImage(
                              'https://i.pinimg.com/736x/4a/7c/e2/4a7ce2c18eaefdcd7786cabdb724a2ba.jpg'),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value.message!.username,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text(
                              value.message!.message,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                  // }
                },
                separatorBuilder: (context, index) => Constants.height20,
              );
            }
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer<LiveViewController>(
              builder: (context, value, child) => Container(
                height: 55,
                width: 324,
                decoration: BoxDecoration(
                  color: Palatte.textFieldColor.withOpacity(0.27),
                  border: Border.all(color: Palatte.strokeColor),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: value.textController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        hintText: 'Type Your Comment',
                        hintStyle: const TextStyle(color: Palatte.hintColor),
                        border: InputBorder.none,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                              onTap: () => value.handleSubmitted(
                                  value.textController.text, false),
                              child: const Icon(Icons.send,
                                  color: Palatte.hintColor)),
                        )),
                    onSubmitted: (val) =>
                        value.handleSubmitted(value.textController.text, false),
                  ),
                ),
              ),
            ),
            // _buildGiftWidget(context, streamer),
          ],
        ),
        Constants.height50,
      ],
    );
  }
}
