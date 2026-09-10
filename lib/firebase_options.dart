// Firebase project "Pokopay" (pokopay-2d7af). These are client identifiers,
// not secrets; access is governed by Firebase rules and API restrictions.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions? get currentPlatform {
    if (kIsWeb) return null;
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => android,
      TargetPlatform.iOS => ios,
      _ => null,
    };
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBKmaKqaEjnZ8PiKweai2RxTnWpmTSlu64',
    appId: '1:906041223082:android:08704f599556c16704add3',
    messagingSenderId: '906041223082',
    projectId: 'pokopay-2d7af',
    storageBucket: 'pokopay-2d7af.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBB9fT9W2veEUNrJi75TpCqLDCo6GlpI_M',
    appId: '1:906041223082:ios:cac865bcf976d08c04add3',
    messagingSenderId: '906041223082',
    projectId: 'pokopay-2d7af',
    storageBucket: 'pokopay-2d7af.firebasestorage.app',
    iosBundleId: 'com.pokopay.pokopay',
  );
}
