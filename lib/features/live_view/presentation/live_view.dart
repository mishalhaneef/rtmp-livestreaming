import 'package:flutter/material.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/core/icons.dart';
import 'package:livestream/features/home/model/home/stream_cover_model.dart';
import 'package:livestream/features/live_view/application/live_view_controller.dart';
import 'package:livestream/features/live_view/presentation/live_view_appbar.dart';
import 'package:livestream/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../../core/colors.dart';
import '../../../routes/app_routes.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key, required this.streamer});

  final StreamCoverModel streamer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(streamer.thumbnail),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 400,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                height: 250,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
              ),
            ),
            const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
                // color: Palatte.theme,
              ),
            ),
            Column(
              children: [
                Constants.height50,
                LiveViewAppBar(streamer: streamer),
                const Spacer(),
                _buildLiveChats(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCommentField(),
                    _buildGiftWidget(context, streamer.streamerName),
                  ],
                ),
                Constants.height50,
              ],
            ),
          ],
        ),
      ),
    );
  }

  Consumer<LiveViewController> _buildLiveChats() {
    return Consumer<LiveViewController>(
      builder: (context, value, child) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(28.0),
        reverse: true,
        shrinkWrap: true,
        itemCount: value.messages.length < 5 ? value.messages.length : 5,
        itemBuilder: (context, index) {
          final data = value.messages[index];
          if (data.isDonation) {
            return Opacity(
              opacity: index >= 3 ? 0.4 : 1,
              child: Row(
                children: [
                  const CircleAvatar(
                    maxRadius: 20,
                    backgroundImage: NetworkImage(
                        'https://i.pinimg.com/736x/4a/7c/e2/4a7ce2c18eaefdcd7786cabdb724a2ba.jpg'),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          const Text(
                            'Peter Parker Gifted  ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 193, 193, 193),
                            ),
                          ),
                          Text(
                            '${data.message}\$ !!!',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Opacity(
              opacity: index >= 3 ? 0.4 : 1,
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
                      const Text(
                        'Peter Parker',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        data.message,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        },
        separatorBuilder: (context, index) => Constants.height20,
      ),
    );
  }

  Widget _buildGiftWidget(BuildContext context, String streamerName) {
    final provider = Provider.of<LiveViewController>(context, listen: false);
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            titlePadding: const EdgeInsets.fromLTRB(40, 50, 40, 20),
            actionsPadding: const EdgeInsets.fromLTRB(40, 20, 40, 50),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('Gift to $streamerName'),
            // buttonPadding: buttonPadding,
            // contentPadding: contentPadding,
            content: Container(
              height: 53,
              width: MediaQuery.of(context).size.width / 2,
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
                child: TextField(
                  controller: provider.textController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter Gift Amount',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.money),
                  ),
                ),
              ),
            ),

            elevation: 0.2,
            actions: [
              AppButton(
                hint: const Text(
                  'Send',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Palatte.themeGreenColor,
                onTap: () {
                  if (provider.textController.text.isNotEmpty) {
                    provider.handleSubmitted(
                        provider.textController.text, true);
                    NavigationHandler.pop(context);
                  }
                },
              ),
            ],
          );
        },
      ),
      child: Container(
        height: 53,
        decoration: BoxDecoration(
            border: Border.all(color: Palatte.strokeColor),
            borderRadius: BorderRadius.circular(100)),
        child: CircleAvatar(
          backgroundColor: Palatte.textFieldColor.withOpacity(0.27),
          radius: 27,
          child: Image.asset(
            AppIcon.gift,
            height: 25,
          ),
        ),
      ),
    );
  }

  Widget _buildCommentField() {
    return Consumer<LiveViewController>(
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
                      child: const Icon(Icons.send, color: Palatte.hintColor)),
                )),
            onSubmitted: (val) =>
                value.handleSubmitted(value.textController.text, false),
          ),
        ),
      ),
    );
  }
}
