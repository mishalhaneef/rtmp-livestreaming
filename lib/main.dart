import 'package:flutter/material.dart';
import 'package:livestream/controller/bottom_nav_controller.dart';
import 'package:livestream/features/chats/application/chat_controller.dart';
import 'package:livestream/features/live_setup/application/live_setup_controller.dart';
import 'package:livestream/features/search/application/search_controller.dart';
import 'package:livestream/splashscreen.dart';
import 'package:provider/provider.dart';

import 'features/live_view/application/live_view_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavigationBarController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LiveController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LiveViewController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserSearchController(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Live Stream',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen()),
    );
  }
}
