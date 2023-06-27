import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/features/search/application/search_controller.dart';
import 'package:provider/provider.dart';

import '../../../routes/app_routes.dart';
import '../../../widgets/textfield.dart';
import '../../chats/presentation/chat_room.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserSearchController>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Search',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              ),
            ),
            Constants.height30,
            AppTextField(
              hint: 'Search by username',
              suffixIcon: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.search),
              ),
              onChanged: (p0) => value.onSearch(),
            ),
            Constants.height50,
            if (value.isSearching)
              ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      maxRadius: 30,
                      backgroundImage: NetworkImage(
                          'https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D'),
                    ),
                    title: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dan',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => NavigationHandler.navigateTo(
                              context, const ChatRoom()),
                          child: const Icon(
                            CupertinoIcons.chat_bubble_fill,
                            color: Palatte.themeGreenColor,
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.fromLTRB(80, 10, 10, 10),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
