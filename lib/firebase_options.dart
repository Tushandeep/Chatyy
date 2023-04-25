// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBfWjljMVIqFYDakIENwxr5QauesDKh59s',
    appId: '1:745467305195:web:0b4dc8ae6971373f2e72ae',
    messagingSenderId: '745467305195',
    projectId: 'chaty-f88db',
    authDomain: 'chaty-f88db.firebaseapp.com',
    storageBucket: 'chaty-f88db.appspot.com',
    measurementId: 'G-ZPT06E5R0H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC4vnChMrtq8VUDDgASyden_qjROcgQFWQ',
    appId: '1:745467305195:android:93db30b60f115d0a2e72ae',
    messagingSenderId: '745467305195',
    projectId: 'chaty-f88db',
    storageBucket: 'chaty-f88db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAa0DmBrWk_rQ9IZH92vOYIoqoCeZIMcwI',
    appId: '1:745467305195:ios:a2324c012dbeeefa2e72ae',
    messagingSenderId: '745467305195',
    projectId: 'chaty-f88db',
    storageBucket: 'chaty-f88db.appspot.com',
    iosClientId: '745467305195-vrjfl1arn17t2quckt7q7m906d7jvn1u.apps.googleusercontent.com',
    iosBundleId: 'com.deep.chatyy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAa0DmBrWk_rQ9IZH92vOYIoqoCeZIMcwI',
    appId: '1:745467305195:ios:bcc8fc989aaadaee2e72ae',
    messagingSenderId: '745467305195',
    projectId: 'chaty-f88db',
    storageBucket: 'chaty-f88db.appspot.com',
    iosClientId: '745467305195-6fvpjm0qu189o2acucivq4ehpaarlmh0.apps.googleusercontent.com',
    iosBundleId: 'com.deep.chatyy.RunnerTests',
  );
}