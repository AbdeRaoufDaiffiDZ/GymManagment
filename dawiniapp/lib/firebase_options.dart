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
    apiKey: 'AIzaSyBFC06zgh-S-vq9c4_K-X-_Dn0VFcNN8-0',
    appId: '1:511171532932:web:3506fc7ab230a028e78ad1',
    messagingSenderId: '511171532932',
    projectId: 'dawini-cec17',
    authDomain: 'dawini-cec17.firebaseapp.com',
    databaseURL: 'https://dawini-cec17-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'dawini-cec17.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC0C59kNz1qQgI8U6rBqssR6Z1zXcx2h14',
    appId: '1:511171532932:android:a15c966779b50226e78ad1',
    messagingSenderId: '511171532932',
    projectId: 'dawini-cec17',
    databaseURL: 'https://dawini-cec17-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'dawini-cec17.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmaZJdbXL83CwwbWdKmh5LAFLwkdyOpfE',
    appId: '1:511171532932:ios:160ba1484bd96018e78ad1',
    messagingSenderId: '511171532932',
    projectId: 'dawini-cec17',
    databaseURL: 'https://dawini-cec17-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'dawini-cec17.appspot.com',
    iosBundleId: 'com.dawini.app.dawiniFull',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDmaZJdbXL83CwwbWdKmh5LAFLwkdyOpfE',
    appId: '1:511171532932:ios:2a7307270d3f8293e78ad1',
    messagingSenderId: '511171532932',
    projectId: 'dawini-cec17',
    databaseURL: 'https://dawini-cec17-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'dawini-cec17.appspot.com',
    iosBundleId: 'com.dawini.app.dawiniFull.RunnerTests',
  );
}
