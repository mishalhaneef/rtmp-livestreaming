import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/core/debouncer.dart';
import 'package:livestream/core/indicator.dart';
import 'package:livestream/features/profile/presentation/widget/user_details.dart';
import 'package:livestream/features/search/application/search_controller.dart';
import 'package:provider/provider.dart';

import '../../../widgets/textfield.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userSearchTextfieldController =
        TextEditingController();
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
              controller: userSearchTextfieldController,
              suffixIcon: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.search),
              ),
              onChanged: (p0) {
                Debouncer _debouncer =
                    Debouncer(delay: const Duration(milliseconds: 500));

                _debouncer.debounce(() async {
                  await value.searchUsers(userSearchTextfieldController.text);
                });
              },
            ),
            Constants.height50,
            if (value.isSearching)
              progressIndicator(Colors.black)
            else if (value.searchResult.users == null)
              const SizedBox()
            else if (value.searchResult.users != null)
              ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: value.searchResult.users!.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = value.searchResult.users![index];
                  return ListTile(
                    leading: CircleAvatar(
                      maxRadius: 30,
                      backgroundImage: NetworkImage(user.image!),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.username ?? '',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => showBottomSheet(
                            elevation: 2,
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  children: [UserDetail(user: user)],
                                ),
                              );
                            },
                          ),
                          child: const Icon(
                            CupertinoIcons.right_chevron,
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
