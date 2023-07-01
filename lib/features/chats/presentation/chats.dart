import 'package:flutter/material.dart';
import 'package:livestream/features/chats/presentation/chat_room.dart';
import 'package:livestream/routes/app_routes.dart';
import 'package:livestream/widgets/textfield.dart';

import '../../../core/constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Chats',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
          ),
        ),
        Constants.height30,
        AppTextField(
          hint: 'Search...',
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.search),
          ),
        ),
        Constants.height50,
        Center(
          child: Text("Chat is not Available"),
        )
        // _buildChatLIst(),
      ],
    ));
  }

  ListView _buildChatLIst() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return _buildChatTile(context);
      },
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.fromLTRB(80, 10, 10, 10),
        child: Divider(
          thickness: 1,
        ),
      ),
    );
  }

  GestureDetector _buildChatTile(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationHandler.navigateTo(context, const ChatRoom()),
      child: const ListTile(
        leading: CircleAvatar(
          maxRadius: 30,
          backgroundImage: NetworkImage(
              'https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('1:14 pm'),
          ],
        ),
      ),
    );
  }
}
