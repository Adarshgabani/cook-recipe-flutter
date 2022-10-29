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
    apiKey: 'AIzaSyCdrewcDRyj0VtoLwHr20bTys6jvAjkhDI',
    appId: '1:1071837432217:web:de32fcc1657445c8d8eb08',
    messagingSenderId: '1071837432217',
    projectId: 'cook-recipe-flutter',
    authDomain: 'cook-recipe-flutter.firebaseapp.com',
    storageBucket: 'cook-recipe-flutter.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_S21ugKv8MZv3KearqZ84mXooVbMHZlc',
    appId: '1:1071837432217:android:cf30b087a342ca68d8eb08',
    messagingSenderId: '1071837432217',
    projectId: 'cook-recipe-flutter',
    storageBucket: 'cook-recipe-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBQRryWIicfSaPooCa6UcZ9qGFggwkyWWw',
    appId: '1:1071837432217:ios:af7537848ad151b2d8eb08',
    messagingSenderId: '1071837432217',
    projectId: 'cook-recipe-flutter',
    storageBucket: 'cook-recipe-flutter.appspot.com',
    iosClientId: '1071837432217-nvh6ilkj4gd7v02dgv6ou2pbbiv3cqtu.apps.googleusercontent.com',
    iosBundleId: 'com.example.cookRecipe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBQRryWIicfSaPooCa6UcZ9qGFggwkyWWw',
    appId: '1:1071837432217:ios:af7537848ad151b2d8eb08',
    messagingSenderId: '1071837432217',
    projectId: 'cook-recipe-flutter',
    storageBucket: 'cook-recipe-flutter.appspot.com',
    iosClientId: '1071837432217-nvh6ilkj4gd7v02dgv6ou2pbbiv3cqtu.apps.googleusercontent.com',
    iosBundleId: 'com.example.cookRecipe',
  );
}
