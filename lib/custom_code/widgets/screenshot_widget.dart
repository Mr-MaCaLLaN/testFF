// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

class ScreenshotWidget extends StatefulWidget {
  const ScreenshotWidget({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _ScreenshotWidgetState createState() => _ScreenshotWidgetState();
}

class _ScreenshotWidgetState extends State<ScreenshotWidget> {
  String facebookId = "902774077523692";

  var imageBackground = "https://pngimg.com/d/mario_PNG125.png";
  var imgPost = "https://pngimg.com/d/mario_PNG125.png";
  String imageBackgroundPath = "";
  String postBackgroundPath = "";

  @override
  void initState() {
    super.initState();
    copyBundleAssets();
  }

  Future<void> copyBundleAssets() async {
    imageBackgroundPath = await copyImage(imageBackground);
    postBackgroundPath = await copyImage(imgPost);
  }

  Future<String> copyImage(String filename) async {
    final tempDir = await getApplicationDocumentsDirectory();
    var response = await Dio()
        .get(filename, options: Options(responseType: ResponseType.bytes));
    final assetPath = '${tempDir.path}/test.png';
    File file = await File(assetPath).create();
    await file.writeAsBytes(Uint8List.fromList(response.data));
    return file.path;
  }

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Screenshot(
          controller: screenshotController,
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Instagram",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 40),
                      ElevatedButton(
                        child: Icon(Icons.gradient),
                        onPressed: () async {
                          try {
                            SocialShare.shareInstagramStory(
                              appId: facebookId,
                              imagePath: postBackgroundPath,
                              backgroundBottomColor: "FFFFFF",
                              backgroundTopColor: "FFFFFF",
                            ).then((data) {
                              Widget okButton = TextButton(
                                child: Text("OK"),
                                onPressed: () => Navigator.pop(context, true),
                              );

                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text("My title"),
                                content: Text('error caught: $data'),
                                actions: [
                                  okButton,
                                ],
                              );

                              // show the dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            });
                          } catch (e) {
                            Widget okButton = TextButton(
                              child: Text("OK"),
                              onPressed: () => Navigator.pop(context, true),
                            );

                            // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              title: Text("My title"),
                              content: Text('error caught: $e'),
                              actions: [
                                okButton,
                              ],
                            );

                            // show the dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          }
                        },
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        child: Icon(Icons.image),
                        onPressed: () async {
                          SocialShare.shareInstagramStory(
                            appId: facebookId,
                            imagePath: postBackgroundPath,
                            backgroundResourcePath: imageBackgroundPath,
                          ).then((data) {
                            print(data);
                          });
                        },
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Facebook",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 40),
                      SizedBox(width: 20),
                      SizedBox(width: 20),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Get all Apps",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 40),
                      ElevatedButton(
                        child: Icon(Icons.text_fields),
                        onPressed: () async {
                          SocialShare.checkInstalledAppsForShare().then((data) {
                            Widget okButton = TextButton(
                              child: Text("OK"),
                              onPressed: () => Navigator.pop(context, true),
                            );

                            // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              title: Text("My title"),
                              content: Text(data.toString()),
                              actions: [
                                okButton,
                              ],
                            );

                            // show the dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                            print(data.toString());
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
