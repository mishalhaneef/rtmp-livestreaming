import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/core/indicator.dart';
import 'package:livestream/features/home/presentation/widgets/fyp.dart';
import 'package:livestream/features/home/presentation/widgets/welcome_text.dart';
import 'package:provider/provider.dart';

import '../../../configs/api_base_service.dart';
import '../../../controller/user_base_controller.dart';
import '../../../core/user_preference_manager.dart';
import '../../../model/live_show.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dio = Dio();

  Future<List<Live>?> getApiCall() async {
    try {
      Response response = await dio.get("http://5.161.179.168:3000/lives");
      logApiResponse(response);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['lives'] != null && data['lives'] is List) {
          final lives =
              List<Live>.from(data['lives'].map((json) => Live.fromJson(json)));
          return lives;
        } else {
          return [];
        }
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioException) {
        print(e);
      }
      print('Get Request Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await UserPreferenceManager.getUserDetails(userController);
    });
    return Scaffold(
        // Consumer<UserController>(
        // builder: (context, value, child) {
        //   if (value.isFetching || value.userModel.user == null) {
        //     return progressIndicator(Colors.black);
        //   } else {
        //       return ListView(
        //         physics: const BouncingScrollPhysics(),
        //         children: [
        //           WelcomeText(userFullName: value.userModel.user!.name),
        //           Constants.height20,
        //           // const AppTextField(
        //           //   hint: 'Search...',
        //           //   suffixIcon: Padding(
        //           //     padding: EdgeInsets.only(right: 10),
        //           //     child: Icon(Icons.search),
        //           //   ),
        //           // ),
        // // Constants.height30,
        // _buildFYPlabel(),
        // const ForYouPage()
        //         ],
        //       );
        //     }
        //   },
        //)
        body: Consumer<UserController>(builder: (context, value, child) {
      if (value.isFetching || value.userModel.user == null) {
        return progressIndicator(Colors.black);
      } else {
        return FutureBuilder<List<Live>?>(
          future: getApiCall(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.black));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final lives = snapshot.data!;
              if (lives.isNotEmpty) {
                // Display the list of lives
                return ListView.builder(
                  //shrinkWrap: true,
                  itemCount: lives.length,
                  itemBuilder: (context, index) {
                    print('=================> ${lives.length}');
                    //log('=================> ${lives[index].lives?[index].user?.image}');
                    // Build your list item widget
                    return Column(
                      children: [
                        Row(
                          children: [
                            WelcomeText(
                                userFullName: value.userModel.user!.name),
                          ],
                        ),
                        Constants.height30,
                        _buildFYPlabel(),
                        ForYouPage(
                            length: lives.length,
                            image: value.userModel.user!.image ??
                                "https://t3.ftcdn.net/jpg/04/62/93/66/360_F_462936689_BpEEcxfgMuYPfTaIAOC1tCDurmsno7Sp.jpg",
                            name: value.userModel.user!.name),

                        // ListTile(
                        //   title:
                        //   subtitle: Text('User: ${live.user}'),
                        //   // Other fields and UI elements
                        // ),
                      ],
                    );
                  },
                );
              } else {
                // Empty list message
                return Column(
                  children: [
                    Row(
                      children: [
                        WelcomeText(userFullName: value.userModel.user!.name),
                      ],
                    ),
                    Constants.height30,
                    _buildFYPlabel(),
                    const SizedBox(height: 10),
                    Text('No streams available'),
                  ],
                );
              }
            } else {
              // No data message
              return Text('No data');
            }
          },
        );
      }
    }));
  }

  Padding _buildFYPlabel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
      child: Row(
        children: [
          const Text(
            'For You',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
                color: Palatte.red.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
              child: Text(
                'LIVE',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
