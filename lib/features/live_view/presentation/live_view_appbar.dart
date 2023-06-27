import 'package:flutter/material.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/features/home/model/home/stream_cover_model.dart';
import 'package:livestream/features/live_view/application/live_view_controller.dart';
import 'package:livestream/routes/app_routes.dart';
import 'package:provider/provider.dart';

class LiveViewAppBar extends StatelessWidget {
  const LiveViewAppBar({
    super.key,
    required this.streamer,
  });

  final StreamCoverModel streamer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<LiveViewController>(
          builder: (context, value, child) => IconButton(
            onPressed: () {
              value.messages.clear();
              NavigationHandler.pop(context);
            },
            icon: Icon(
              Icons.cancel,
              color: Colors.white.withOpacity(0.4),
              size: 30,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Stack(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.red,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(streamer.streamerProfilePicture),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Palatte.red,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                    child: Text(
                      'LIVE',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              streamer.streamerName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
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
                      streamer.viewCount,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
