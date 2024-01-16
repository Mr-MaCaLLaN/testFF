import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBRSxmmRESybvDLgXQnIlJ02FkPRNjtdIk",
            authDomain: "share-vqbvjq.firebaseapp.com",
            projectId: "share-vqbvjq",
            storageBucket: "share-vqbvjq.appspot.com",
            messagingSenderId: "711078847474",
            appId: "1:711078847474:web:31a59696fe47659bd0016b"));
  } else {
    await Firebase.initializeApp();
  }
}
