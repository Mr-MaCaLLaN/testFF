// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:social_share/social_share.dart';

Future shareToInstagrammStory(String path) async {
  await SocialShare.checkInstalledAppsForShare();
  String facebookId = "1003040447654658";
  await SocialShare.shareInstagramStory(
    appId: facebookId,
    imagePath: "logo_icon_2.png",
    backgroundTopColor: "#ffffff",
    backgroundBottomColor: "#000000",
  ).then((data) {
    print(data);
  });
}
