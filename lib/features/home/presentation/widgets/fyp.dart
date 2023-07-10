import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:livestream/core/indicator.dart';
import 'package:livestream/features/home/application/home_controller.dart';
import 'package:livestream/features/home/model/stream_model.dart';
import 'package:livestream/features/live_view/application/live_view_controller.dart';
import 'package:livestream/features/live_view/presentation/live_view.dart';
import 'package:livestream/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../../controller/user_base_controller.dart';
import '../../../../core/user_preference_manager.dart';

class ForYouPage extends StatelessWidget {
  const ForYouPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context, listen: false);
    final liveController =
        Provider.of<LiveViewController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // final pref = await SharedPreferences.getInstance();
      await UserPreferenceManager.getUserDetails(userController);
    });
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Consumer<StreamDisplayController>(
        builder: (context, value, child) {
          log(value.streamModel.lives.toString());
          if (value.isFetching) {
            return progressIndicator(Colors.black);
          } else if (value.streamModel.lives != []) {
            return StreamBuilder<List<StreamModel>>(
              stream: value.getLiveStream(),
              builder: (context, snapshot) => GridView.count(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 1 * 1 / 1.4,
                children:
                    List.generate(value.streamModel.lives!.length, (index) {
                  final streamer = value.streamModel.lives![index];
                  log(streamer.user!.image.toString());
                  return LiveViewBuilder(
                    streamer: streamer,
                    userController: userController,
                    liveController: liveController,
                  );
                }),
              ),
            );
          } else {
            return const Center(
              child: Text(
                "No Live Avaiable",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class LiveViewBuilder extends StatelessWidget {
  const LiveViewBuilder({
    super.key,
    required this.streamer,
    required this.userController,
    required this.liveController,
  });

  final Live streamer;
  final UserController userController;
  final LiveViewController liveController;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await liveController.getLiveViewCount(streamer.id!);
    });
    return GestureDetector(
      onTap: () => NavigationHandler.navigateWithAnimation(context,
          LiveScreen(streamer: streamer, user: userController.userModel.user!),
          slide: Slides.slideUp),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(streamer.user!.image!),
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(colors: [
                    Colors.black,
                    Colors.transparent,
                  ], begin: Alignment.bottomCenter)),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black.withOpacity(0.6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.white,
                                size: 17,
                              ),
                              const SizedBox(width: 5),
                              // subscribers length is the live count

                              Text(
                                liveController.liveViewersModel.subscribers ==
                                        null
                                    ? '0'
                                    : liveController
                                        .liveViewersModel.subscribers!.length
                                        .toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        streamer.user!.username ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
