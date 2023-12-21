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
    apiKey: 'AIzaSyAhPorTGTd51vNmA0fV-1JcxgSTGCtBHC8',
    appId: '1:535893186920:web:d6b11796b42ee28a9bdedd',
    messagingSenderId: '535893186920',
    projectId: 'personal-finance-tracker-c9593',
    authDomain: 'personal-finance-tracker-c9593.firebaseapp.com',
    storageBucket: 'personal-finance-tracker-c9593.appspot.com',
    measurementId: 'G-49DFTGXCSE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTxm5perkAHpK0miyZfot0jz-dcYrdr5c',
    appId: '1:535893186920:android:cefb4f94299b191e9bdedd',
    messagingSenderId: '535893186920',
    projectId: 'personal-finance-tracker-c9593',
    storageBucket: 'personal-finance-tracker-c9593.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA0EAlAYw6LxGrvHl0fUeebV3uvc8eOn2Q',
    appId: '1:535893186920:ios:67023880704941769bdedd',
    messagingSenderId: '535893186920',
    projectId: 'personal-finance-tracker-c9593',
    storageBucket: 'personal-finance-tracker-c9593.appspot.com',
    iosBundleId: 'com.example.personalFinanceTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA0EAlAYw6LxGrvHl0fUeebV3uvc8eOn2Q',
    appId: '1:535893186920:ios:27aad3c61f1cfa759bdedd',
    messagingSenderId: '535893186920',
    projectId: 'personal-finance-tracker-c9593',
    storageBucket: 'personal-finance-tracker-c9593.appspot.com',
    iosBundleId: 'com.example.personalFinanceTracker.RunnerTests',
  );
}