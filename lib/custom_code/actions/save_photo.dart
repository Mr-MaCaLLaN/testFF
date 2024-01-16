// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';
import "package:path_provider/path_provider.dart";

Future<String> savePhoto(String imageUrl) async {
  var response = await Dio()
      .get(imageUrl, options: Options(responseType: ResponseType.bytes));
  final directory = await getApplicationDocumentsDirectory();
  final rootPath = directory.path;
  final filePath = '${directory.path}/edited_image.jpg';
  final File savedImage = File(filePath);
  await savedImage.writeAsBytes(Uint8List.fromList(response.data));
  return '${directory.path}/edited_image.jpg';
}
