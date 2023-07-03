import 'package:flutter/material.dart';
import 'package:livestream/features/home/application/home_controller.dart';
import 'package:livestream/features/live_view/presentation/live_view.dart';
import 'package:livestream/routes/app_routes.dart';
import 'package:provider/provider.dart';

class ForYouPage extends StatelessWidget {
  const ForYouPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Consumer<StreamDisplayController>(
        builder: (context, value, child) {
          return GridView.count(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1 * 1 / 1.4,
            children: List.generate(value.streamModel.lives!.length, (index) {
              final streamer = value.streamModel.lives![index];
              return GestureDetector(
                onTap: () => NavigationHandler.navigateWithAnimation(
                    context, LiveScreen(streamer: streamer),
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
                                        Text(
                                          streamer.v.toString(),
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
            }),
          );
        },
      ),
    );
  }
}
