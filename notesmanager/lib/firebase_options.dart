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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAzx_yGuz0KEga4oR_JsZBVkIYzA5qFGb0',
    appId: '1:663608846570:web:259155c987dacda6c00f93',
    messagingSenderId: '663608846570',
    projectId: 'notesmanager',
    authDomain: 'notesmanager-46f8d.firebaseapp.com',
    storageBucket: 'notesmanager.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCb54EM_0WgDwb2UTu5GrtpBj1aVOFc9LQ',
    appId: '1:663608846570:android:528bb0afd591e21ac00f93',
    messagingSenderId: '663608846570',
    projectId: 'notesmanager',
    storageBucket: 'notesmanager.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDfOmEQPKAEbSo9GPoE4-uTzrCuzrvZkUo',
    appId: '1:663608846570:ios:1edb467e49a575bbc00f93',
    messagingSenderId: '663608846570',
    projectId: 'notesmanager',
    storageBucket: 'notesmanager.appspot.com',
    iosBundleId: 'com.decryptcode.notesmanager',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDfOmEQPKAEbSo9GPoE4-uTzrCuzrvZkUo',
    appId: '1:663608846570:ios:1edb467e49a575bbc00f93',
    messagingSenderId: '663608846570',
    projectId: 'notesmanager',
    storageBucket: 'notesmanager.appspot.com',
    iosBundleId: 'com.decryptcode.notesmanager',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAzx_yGuz0KEga4oR_JsZBVkIYzA5qFGb0',
    appId: '1:663608846570:web:ccb7249d28cc8b55c00f93',
    messagingSenderId: '663608846570',
    projectId: 'notesmanager',
    authDomain: 'notesmanager-46f8d.firebaseapp.com',
    storageBucket: 'notesmanager.appspot.com',
  );
}
