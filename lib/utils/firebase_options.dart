import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.get('API_KEY'),
    appId: dotenv.get('APP_ID'),
    messagingSenderId: dotenv.get('MESSAGING_SENDER_ID'),
    projectId: dotenv.get('PROJECT_ID'),
    databaseURL: dotenv.get('DATABASE_URL'),
    storageBucket: dotenv.get('STORAGE_BUCKET'),
  );
}
