import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memoria/backend/models/event.dart';

class Dialogs {
  static Future checkFile(BuildContext context, Event event) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('位置情報リクエストが拒否されました'),
          content: const Text('ARコンテンツを使用するためは許可が必要です。'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// await showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: const Text('位置情報リクエストが拒否されました'),
//                         content: const Text('ARコンテンツを使用するためは許可が必要です。'),
//                         actions: <Widget>[
//                           TextButton(
//                             child: const Text('OK'),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ],
//                       );
//                     },
//                   );