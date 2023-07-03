import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livestream/controller/bottom_nav_controller.dart';
import 'package:livestream/controller/user_base_controller.dart';
import 'package:livestream/core/enums.dart';
import 'package:livestream/features/authentication/application/authentication_controller.dart';
import 'package:livestream/features/chats/application/chat_controller.dart';
import 'package:livestream/features/home/application/home_controller.dart';
import 'package:livestream/features/live_setup/application/live_setup_controller.dart';
import 'package:livestream/features/profile/application/profile_controller.dart';
import 'package:livestream/features/search/application/search_controller.dart';
import 'package:livestream/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'features/live_view/application/live_view_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Live Stream',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return const SplashScreen(authStaus: AuthState.waiting);
              // } else {
              if (snapshot.hasData) {
                return const SplashScreen(
                  authStaus: AuthState.authenticated,
                );
              } else {
                return const SplashScreen(authStaus: AuthState.newUser);
              }
            },
          )),
    );
  }
}
