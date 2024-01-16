// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:dio/dio.dart' as Dio;
import 'package:social_share/social_share.dart';

Future instagramStoryPost(
  String image,
  String? backgroundImage,
  Color? backgroundTopColor,
  Color? backgroundBottomColor,
) async {
  String imagePath = "";
  String backgroundImagePath = "";

  final tempDir = await getApplicationDocumentsDirectory();
  var response = await Dio.Dio()
      .get(image, options: Dio.Options(responseType: Dio.ResponseType.bytes));
  final assetPath = '${tempDir.path}/post.png';
  File file = await File(assetPath).create();
  await file.writeAsBytes(Uint8List.fromList(response.data));
  imagePath = file.path;

  if (backgroundImage != null) {
    var responseBackground = await Dio.Dio().get(backgroundImage!,
        options: Dio.Options(responseType: Dio.ResponseType.bytes));
    final assetPathBackground = '${tempDir.path}/background.png';
    File fileBackground = await File(assetPathBackground).create();
    await fileBackground
        .writeAsBytes(Uint8List.fromList(responseBackground.data));
    backgroundImagePath = fileBackground.path;

    SocialShare.shareInstagramStory(
      appId: FFAppState().facebookAppID,
      imagePath: imagePath,
      backgroundResourcePath: backgroundImagePath,
    ).then((data) {
      print(data);
    });
  } else {
    String colorTop = "#" + backgroundTopColor!.toHex().toString();
    String colorBottom = "#" + backgroundBottomColor!.toHex().toString();

    SocialShare.shareInstagramStory(
      appId: FFAppState().facebookAppID,
      imagePath: imagePath,
      backgroundTopColor: colorTop,
      backgroundBottomColor: colorBottom,
    ).then((data) {
      print(data);
    });
  }
}

extension HexColor on Color {
  String _generateAlpha({required int alpha, required bool withAlpha}) {
    if (withAlpha) {
      return alpha.toRadixString(16).padLeft(2, '0');
    } else {
      return '';
    }
  }

  String toHex({bool leadingHashSign = false, bool withAlpha = false}) =>
      '${leadingHashSign ? '#' : ''}'
              '${_generateAlpha(alpha: alpha, withAlpha: withAlpha)}'
              '${red.toRadixString(16).padLeft(2, '0')}'
              '${green.toRadixString(16).padLeft(2, '0')}'
              '${blue.toRadixString(16).padLeft(2, '0')}'
          .toUpperCase();
}
