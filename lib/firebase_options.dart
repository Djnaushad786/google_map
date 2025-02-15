// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyARKwjRU5vykT6_i5h1Qcf9wVSoRJIIh7A',
    appId: '1:770597713768:web:3fc350ad8a3de85ee348dd',
    messagingSenderId: '770597713768',
    projectId: 'chatapp-1d893',
    authDomain: 'chatapp-1d893.firebaseapp.com',
    databaseURL: 'https://chatapp-1d893-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'chatapp-1d893.firebasestorage.app',
    measurementId: 'G-LP42B5ZWP9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCj4qeEaZsN8veHRLsTeADRUk9cN4qQN04',
    appId: '1:770597713768:android:9bc43d4ce086c10fe348dd',
    messagingSenderId: '770597713768',
    projectId: 'chatapp-1d893',
    databaseURL: 'https://chatapp-1d893-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'chatapp-1d893.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDafzenei4ncOzZ1pnPJFRoc8_qVPXRxdE',
    appId: '1:770597713768:ios:843869f2b6ae2ae0e348dd',
    messagingSenderId: '770597713768',
    projectId: 'chatapp-1d893',
    databaseURL: 'https://chatapp-1d893-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'chatapp-1d893.firebasestorage.app',
    iosClientId: '770597713768-21e6gs8ngip3q96q1jb0a4htov0dhcl3.apps.googleusercontent.com',
    iosBundleId: 'com.example.googleMapsApp',
  );
}
