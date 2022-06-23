import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.get('ANDROID_API_KEY'),
    appId: dotenv.get('ANDROID_APP_ID'),
    messagingSenderId: dotenv.get('ANDROID_MESSAGING_SENDER_ID'),
    projectId: dotenv.get('ANDROID_PROJECT_ID'),
    databaseURL: dotenv.get('ANDROID_DATABASE_URL'),
    storageBucket: dotenv.get('ANDROID_STORAGE_BUCKET'),
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: dotenv.get('IOS_API_KEY'),
    appId: dotenv.get('IOS_APP_ID'),
    messagingSenderId: dotenv.get('IOS_MESSAGING_SENDER_ID'),
    projectId: dotenv.get('IOS_PROJECT_ID'),
    databaseURL: dotenv.get('IOS_DATABASE_URL'),
    storageBucket: dotenv.get('IOS_STORAGE_BUCKET'),
  );
}
