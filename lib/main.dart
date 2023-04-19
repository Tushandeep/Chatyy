import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import './screens/auth_screen.dart';
import './screens/chat_screen.dart';
import './screens/splash_screens.dart';
import 'theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ChatyApp());
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp();
  final fbm = FirebaseMessaging.instance;
  fbm.requestPermission();

  // FlutterLocalNotificationsPlugin _notify = FlutterLocalNotificationsPlugin();

  // onLaunch Function
  fbm.getInitialMessage().then((RemoteMessage? message) {
    // print('11111111111111111111111111111111111111');
    // print('Initial Data: ${message!.data}');
    // print('Title: ${message.notification!.title}');
    // print('Body: ${message.notification!.body}');
    // print('11111111111111111111111111111111111111');
  });

  // onMessage Function
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print('22222222222222222222222222222222222222222222222');
    // print('onMessage Data: ${message.data}');
    // print('Title: ${message.notification!.title}');
    // print('Body: ${message.notification!.body}');
    // print('22222222222222222222222222222222222222222222222');
  });

  // onResume Function
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // print('333333333333333333333333333333333333333333');
    // print('onMessageOpenedApp: ${message.data}');
    // print('Title: ${message.notification!.title}');
    // print('Body: ${message.notification!.body}');
    // print('333333333333333333333333333333333333333333');
  });
}

class ChatyApp extends StatelessWidget {
  const ChatyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lets Chat',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _initFirebase(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (_, streamSnap) {
              if (streamSnap.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              if (streamSnap.hasData) {
                return const ChatScreen();
              }
              return const AuthScreen();
            },
          );
        },
      ),
      theme: theme,
    );
  }
}
