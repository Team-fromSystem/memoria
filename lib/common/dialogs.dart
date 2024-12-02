import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoria/backend/fileDownloader/fileDownloader.dart';
import 'package:memoria/backend/models/event.dart';
import 'package:memoria/utils/notification.dart';

class Dialogs {
  static Future fileChecker(
      BuildContext context, Event event, bool isFilesExist) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('イベント関連データを\nダウンロードしますか？'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                '・ARコンテンツで使用するデータをダウンロードします。\n・3Dモデル、画像トラッキング用の画像を含みます。\n・Wi-Fi環境下でのダウンロードを推奨します。',
                style: TextStyle(
                  overflow: TextOverflow.clip,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              if (isFilesExist)
                const Row(
                  children: <Widget>[
                    Icon(Icons.check_box),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Text(
                        style: TextStyle(color: Colors.blueAccent),
                        "全てのイベント関連データの\nダウンロードが完了しました。"),
                  ],
                )
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Card(
              elevation: 6.0,
              child: AnimatedButton(
                width: 140,
                height: 60,
                borderRadius: 12,
                text: 'ダウンロード',
                textStyle: GoogleFonts.nunito(
                    fontSize: 16,
                    letterSpacing: 2,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                isReverse: false,
                animationDuration: const Duration(milliseconds: 800),
                selectedTextColor: Colors.black,
                transitionType: TransitionType.LEFT_TOP_ROUNDER,
                backgroundColor: const Color.fromARGB(255, 171, 242, 220),
                selectedGradientColor: LinearGradient(
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  colors: [
                    const Color(0xffe4a972).withOpacity(0.8),
                    const Color(0xff9941d8).withOpacity(0.7),
                  ],
                ),
                onPress: () async {
                  if (event.imageID.isEmpty && event.detectType.contains(1)) {
                    debugPrint("画像トラッキングで使用する画像データが存在しません");
                    return;
                  }
                  final List<FileManager> modelList =
                      await FileDownloader().getfileURL(event.modelID, true);
                  if (modelList.length != event.modelID.length) {
                    debugPrint("エラー：モデルデータが足りていません");
                    return;
                  }
                  if (event.detectType.contains(1)) {
                    final List<FileManager> imageList =
                        await FileDownloader().getfileURL(event.imageID, false);
                    if (imageList.length != event.imageID.length) {
                      debugPrint("エラー：画像データが足りていません");
                      return;
                    }
                    final bool getImage =
                        await FileDownloader().fileDownloader(imageList, false);
                    if (!getImage) {
                      debugPrint("エラー：ダウンロードに失敗しました");
                      return;
                    }
                  } else {
                    debugPrint("今回は画像は使わないぜ");
                  }
                  final bool getModel =
                      await FileDownloader().fileDownloader(modelList, true);
                  if (!getModel) {
                    debugPrint("エラー：ダウンロードに失敗しました");
                    return;
                  }
                  debugPrint("ALL OK");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: const Duration(milliseconds: 1000),
                      content: Text("${event.title} のデータのダウンロードが完了しました")));
                },
              ),
            ),
          ],
        );
      },
    );
  }

  static Future arChecker(BuildContext context, bool isFilesExist,
      bool isRequeatGranted, bool isInsideArea) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('イベントに入場しますか？'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('・以下の条件をすべて満たすと、ARコンテンツを開始できます。'),
              const Text(
                  style: TextStyle(
                      color: Colors.blueAccent,
                      overflow: TextOverflow.ellipsis),
                  overflow: TextOverflow.clip,
                  "イベント関連データのダウンロードが未完了のようです…"),
              const Padding(padding: EdgeInsets.only(top: 10)),
              if (isFilesExist)
                const Row(
                  children: <Widget>[
                    Icon(Icons.check_box),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Flexible(
                        child: FittedBox(
                      child: Text(
                          style: TextStyle(color: Colors.blueAccent),
                          "全てのイベント関連データの\nダウンロードが完了しました。"),
                    )),
                  ],
                )
              else
                const Row(
                  children: <Widget>[
                    Icon(Icons.check_box_outline_blank),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Flexible(
                        child: FittedBox(
                      child: Text(
                          style: TextStyle(color: Colors.blueAccent),
                          "イベント関連データのダウンロードが未完了のようです…"),
                    )),
                  ],
                ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              if (isRequeatGranted)
                const Row(
                  children: <Widget>[
                    Icon(Icons.check_box),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Flexible(
                        child: FittedBox(
                      child: Text(
                          style: TextStyle(color: Colors.blueAccent),
                          "位置情報リクエストが正常に受諾されました。"),
                    )),
                  ],
                )
              else
                const Row(
                  children: <Widget>[
                    Icon(Icons.check_box_outline_blank),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Flexible(
                        child: FittedBox(
                      child: Text(
                          style: TextStyle(color: Colors.blueAccent),
                          "位置情報リクエストが拒否されました。\nARコンテンツを使用するためは許可が必要です"),
                    )),
                  ],
                ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              if (isInsideArea)
                const Row(
                  children: <Widget>[
                    Icon(Icons.check_box),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Flexible(
                        child: FittedBox(
                      child: Text(
                          style: TextStyle(color: Colors.blueAccent),
                          "現在、イベント開催エリア内です。\nようこそ！"),
                    )),
                  ],
                )
              else
                const Row(
                  children: <Widget>[
                    Icon(Icons.check_box_outline_blank),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Text(
                        style: TextStyle(color: Colors.blueAccent),
                        "現在、このイベントの\n開催エリア外のようです…"),
                  ],
                ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Card(
              elevation: 6.0,
              child: AnimatedButton(
                width: 140,
                height: 60,
                borderRadius: 12,
                text: '入場する！',
                textStyle: GoogleFonts.nunito(
                    fontSize: 16,
                    letterSpacing: 2,
                    color: isFilesExist && isRequeatGranted && isInsideArea
                        ? Colors.black
                        : Colors.black54,
                    fontWeight: FontWeight.w400),
                isReverse: false,
                animationDuration: const Duration(milliseconds: 1500),
                selectedTextColor: Colors.black,

                transitionType: TransitionType.LEFT_TOP_ROUNDER,
                //backgroundColor: const Color.fromARGB(255, 171, 242, 220),
                gradient: const LinearGradient(
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  colors: [
                    Color(0xffe4a972),
                    Color.fromARGB(255, 171, 242, 220),
                  ],
                ),
                selectedGradientColor: LinearGradient(
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  colors: [
                    const Color(0xffe4a972).withOpacity(0.8),
                    const Color(0xff9941d8).withOpacity(0.7),
                  ],
                ),
                animatedOn: isFilesExist && isRequeatGranted && isInsideArea
                    ? AnimatedOn.onTap
                    : AnimatedOn.onHover,
                onPress: () async {
                  if (isFilesExist && isRequeatGranted && isInsideArea) {
                    debugPrint("unityWidgetへ");
                    //TODO unityWidgetへ遷移
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  static Future applyNotification(BuildContext context, DateTime eventOpen) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('開催時刻に通知しますか？'),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                scheduleNotification(eventOpen);
              },
            ),
          ],
        );
      },
    );
  }

  static Future deleteNotification(
      BuildContext context, int openHash, String eventTitle) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$eventTitleの通知を削除しますか？'),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                await flutterLocalNotificationsPlugin.cancel(openHash);
              },
            ),
          ],
        );
      },
    );
  }

  static Future registerNewEvent(BuildContext context, Event newEvent) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('新しいEventを登録しますか？'),
          content: Column(
            children: <Widget>[
              Text("タイトル:${newEvent.title}"),
              Text("キャッチコピー:${newEvent.catchCopy}"),
              Text("主催者ID:${newEvent.hostID}"),
              Text("主催者:${newEvent.hostName}"),
              Text("イベント説明:${newEvent.description}"),
              Text("開催場所:${newEvent.location}"),
              Text("エリア半径:${newEvent.areaRadius}"),
              Text("Open:${newEvent.open}"),
              Text("Close:${newEvent.close}"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                final db = FirebaseFirestore.instance;
                DocumentReference docRef =
                    await db.collection("events").add(newEvent.toJson());
                await docRef.collection("Plane").add({
                  "decorationModelID": [0],
                  "mainModelID": [0],
                });
                await docRef.collection("Image").add({
                  "imageID": 0,
                  "modelID": 0,
                  "modelPosition": <String, double>{
                    "x": 0,
                    "y": 0,
                    "z": 0,
                  },
                  "modelRotaion": <String, double>{
                    "x": 0,
                    "y": 0,
                    "z": 0,
                  },
                  "modelSize": 1
                });
                await docRef.collection("Immersal").add({
                  "immersalMapManager": <String, dynamic>{
                    "mapID": 0,
                    "mapPosition": <String, double>{
                      "x": 0,
                      "y": 0,
                      "z": 0,
                    },
                    "mapRotaion": <String, double>{
                      "x": 0,
                      "y": 0,
                      "z": 0,
                    },
                  },
                  "immersalModelManager": <String, dynamic>{
                    "modelID": 0,
                    "modelPosition": <String, double>{
                      "x": 0,
                      "y": 0,
                      "z": 0,
                    },
                    "modelRotaion": <String, double>{
                      "x": 0,
                      "y": 0,
                      "z": 0,
                    },
                    "modelSize": 1
                  },
                  "location": <String, double>{
                    "latitude": 0,
                    "longitude": 0,
                  },
                  "radius": 0
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
