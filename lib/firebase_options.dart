import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyCdIiB8hePkcQGoY7M1b3dII7yORBLh_L0',
    appId: '1:813865623142:web:3e72ce1138b48db40057a7',
    messagingSenderId: '813865623142',
    projectId: 'adit-quiz',
    authDomain: 'adit-quiz.firebaseapp.com',
    storageBucket: 'adit-quiz.appspot.com',
    measurementId: 'G-2Z1D7JN86W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCnjFw9WRtYI9nQYwrOuKMEfYDaO79_iwQ',
    appId: '1:813865623142:android:3fb04ee7d70f93f40057a7',
    messagingSenderId: '813865623142',
    projectId: 'adit-quiz',
    storageBucket: 'adit-quiz.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3V4D3vWOKoLFi5FPkKkYrxBGoOQQl9w4',
    appId: '1:813865623142:ios:9c2b5ed8ea761e360057a7',
    messagingSenderId: '813865623142',
    projectId: 'adit-quiz',
    storageBucket: 'adit-quiz.appspot.com',
    iosBundleId: 'com.example.aditQuiz',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC3V4D3vWOKoLFi5FPkKkYrxBGoOQQl9w4',
    appId: '1:813865623142:ios:31114662076a0c700057a7',
    messagingSenderId: '813865623142',
    projectId: 'adit-quiz',
    storageBucket: 'adit-quiz.appspot.com',
    iosBundleId: 'com.example.aditQuiz.RunnerTests',
  );
}
