import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_video/fl_video.dart';
import 'package:flutter/material.dart';
import 'package:livestream/controller/bottom_nav_controller.dart';
import 'package:livestream/controller/user_base_controller.dart';
import 'package:livestream/core/enums.dart';
import 'package:livestream/features/authentication/application/authentication_controller.dart';
import 'package:livestream/features/chats/application/chat_controller.dart';
import 'package:livestream/features/home/application/home_controller.dart';
import 'package:livestream/features/live_chats/application/live_chat_controller.dart';
import 'package:livestream/features/live_setup/application/live_setup_controller.dart';
import 'package:livestream/features/profile/application/profile_controller.dart';
import 'package:livestream/features/search/application/search_controller.dart';
import 'package:livestream/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:wakelock/wakelock.dart';

import 'firebase_options.dart';
import 'features/live_view/application/live_view_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: false);
  await WakelockPlus.enable();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthenticationController(),
        ),
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
        ChangeNotifierProvider(
          create: (context) => UserController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileController(),
        ),
        ChangeNotifierProvider(
          create: (context) => StreamDisplayController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LiveChatController(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Live Stream',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primarySwatch: Colors.blue,
          ),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.hasData) {
                return const SplashScreen(authStaus: AuthState.authenticated);
              } else {
                return const SplashScreen(authStaus: AuthState.newUser);
              }
            },
          )),
    );
  }
}
