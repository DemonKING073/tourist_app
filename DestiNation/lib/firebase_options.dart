import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyAfBjepHjB-sDpqOPSTQm5BAgBhFxaE490',
    appId: '1:142716240312:web:8f984c4f057da361418f4d',
    messagingSenderId: '142716240312',
    projectId: 'fypdestination',
    authDomain: 'fypdestination.firebaseapp.com',
    storageBucket: 'fypdestination.appspot.com',
    measurementId: 'G-LP1M34M9S8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYdTBJfP7grUYtzXI98qXlyjuXge3geaY',
    appId: '1:142716240312:android:f268c0e634118c7b418f4d',
    messagingSenderId: '142716240312',
    projectId: 'fypdestination',
    storageBucket: 'fypdestination.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDr6ynUxadwIhUuVVpAmwYWJHPkDY9_6b8',
    appId: '1:142716240312:ios:eaf26f48061a0f9a418f4d',
    messagingSenderId: '142716240312',
    projectId: 'fypdestination',
    storageBucket: 'fypdestination.appspot.com',
    iosClientId:
        '142716240312-47n556hgu3okcnfutc1bbjo9eoa5dlq9.apps.googleusercontent.com',
    iosBundleId: 'com.prajwal.destination',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDr6ynUxadwIhUuVVpAmwYWJHPkDY9_6b8',
    appId: '1:142716240312:ios:6919b61b8377f3aa418f4d',
    messagingSenderId: '142716240312',
    projectId: 'fypdestination',
    storageBucket: 'fypdestination.appspot.com',
    iosClientId:
        '142716240312-k0joibs3s7dvtfqm2k4q7q6bv4eqe41b.apps.googleusercontent.com',
    iosBundleId: 'com.prajwal.destination.RunnerTests',
  );
}
