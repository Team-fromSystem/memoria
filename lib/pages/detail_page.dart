import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memoria/backend/fileDownloader/fileDownloader.dart';
import 'package:memoria/backend/models/event.dart';
import 'package:memoria/configs.dart';

class DetailPage extends StatelessWidget {
  final Event event;
  const DetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final List<String> eventLocation = event.location.split('/');
    return Scaffold(
      backgroundColor: const Color.fromARGB(253, 235, 234, 238),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 32),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(95, 0, 0, 0),
                          offset: Offset(0, 2),
                          blurRadius: 3,
                          spreadRadius: 0.2,
                        )
                      ]),
                  child: GestureDetector(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: event.bannerURL,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                      ),
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(left: 18, top: 16),
                alignment: Alignment.bottomLeft,
                child: const Text(
                  "イベント情報",
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 140, 140, 144)),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(65, 0, 0, 0),
                          offset: Offset(0, 3),
                          blurRadius: 3,
                          spreadRadius: 1.2,
                        )
                      ]),
                  width: screenWidth,
                  margin: const EdgeInsets.fromLTRB(0, 3, 0, 16),
                  padding: const EdgeInsets.only(left: 20, top: 12, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                          text: TextSpan(
                              text: "${event.title}\n",
                              style: const TextStyle(
                                  height: 1.6,
                                  color: Color(0xff333333),
                                  fontSize: 30),
                              children: <TextSpan>[
                            //const TextSpan(text: "\n"),
                            TextSpan(
                              text: event.catchCopy,
                              style: const TextStyle(
                                  color: Color(0xff333333), fontSize: 20),
                            ),
                            const TextSpan(
                              text: "\n\n",
                              style: TextStyle(
                                  color: Color(0xff333333), fontSize: 12),
                            ),
                            const TextSpan(
                              text: "主催： aaa\n\n",
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 18,
                                  height: 1.3),
                            ),
                            TextSpan(
                              text: event.description.replaceAll('\\n', '\n'),
                              style: const TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 16,
                                  height: 1.5),
                            ),
                          ])),
                      const Divider(
                        height: 24,
                        thickness: 1.5,
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(left: 18),
                alignment: Alignment.bottomLeft,
                child: const Text(
                  "開催場所",
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 140, 140, 144)),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(65, 0, 0, 0),
                          offset: Offset(0, 3),
                          blurRadius: 3,
                          spreadRadius: 1.2,
                        )
                      ]),
                  width: screenWidth,
                  margin: const EdgeInsets.fromLTRB(10, 3, 10, 16),
                  padding: const EdgeInsets.only(left: 20, top: 16, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                          text: TextSpan(
                              text: eventLocation[0],
                              style: const TextStyle(
                                  height: 1.1,
                                  color: Color(0xff333333),
                                  fontSize: 26),
                              children: <TextSpan>[
                            const TextSpan(text: "\n"),
                            TextSpan(
                              text: eventLocation[1],
                              style: const TextStyle(
                                  color: Color(0xff333333), fontSize: 26),
                            ),
                            const TextSpan(text: "\n"),
                            TextSpan(
                              text: eventLocation[2],
                              style: const TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 22,
                                  height: 2),
                            ),
                          ])),
                      const Divider(
                        thickness: 1.5,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("会場付近のmapを表示",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 140, 140, 144))),
                          IconButton(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            onPressed: null,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 34,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(left: 18),
                alignment: Alignment.bottomLeft,
                child: const Text(
                  "開催期間",
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 140, 140, 144)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(65, 0, 0, 0),
                                offset: Offset(0, 3),
                                blurRadius: 3,
                                spreadRadius: 1.2,
                              )
                            ]),
                        //width: screenWidth,
                        margin: const EdgeInsets.fromLTRB(10, 3, 5, 16),
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                                text: TextSpan(
                                    text: "Open",
                                    style: const TextStyle(
                                        height: 1.1,
                                        color: Color(0xff333333),
                                        fontSize: 26),
                                    children: <TextSpan>[
                                  const TextSpan(
                                    text: "\n\n",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  TextSpan(
                                    text: "${event.open.year} 年\n",
                                    style: const TextStyle(fontSize: 21),
                                  ),
                                  TextSpan(
                                    text:
                                        "${event.open.month}/${event.open.day}\n(${getWeekDayJP(event.open.weekday)}曜日)\n",
                                    style: const TextStyle(
                                        color: Color(0xff333333), fontSize: 24),
                                  ),
                                  TextSpan(
                                    text:
                                        "${event.open.hour}:${event.open.minute} ~ ${event.close.hour}:${event.close.minute}",
                                    style: const TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 22,
                                        height: 2),
                                  ),
                                ])),
                          ],
                        )),
                  ),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(65, 0, 0, 0),
                                offset: Offset(0, 3),
                                blurRadius: 3,
                                spreadRadius: 1.2,
                              )
                            ]),
                        //width: screenWidth,
                        margin: const EdgeInsets.fromLTRB(5, 3, 10, 16),
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                                text: TextSpan(
                                    text: "Close",
                                    style: const TextStyle(
                                        height: 1.1,
                                        color: Color(0xff333333),
                                        fontSize: 26),
                                    children: <TextSpan>[
                                  const TextSpan(
                                    text: "\n\n",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  TextSpan(
                                    text: "${event.close.year} 年\n",
                                    style: const TextStyle(fontSize: 21),
                                  ),
                                  TextSpan(
                                    text:
                                        "${event.close.month}/${event.close.day}\n(${getWeekDayJP(event.close.weekday)}曜日)\n",
                                    style: const TextStyle(
                                        color: Color(0xff333333), fontSize: 24),
                                  ),
                                  TextSpan(
                                    text:
                                        "${event.open.hour}:${event.open.minute} ~ ${event.close.hour}:${event.close.minute}",
                                    style: const TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 22,
                                        height: 2),
                                  ),
                                ])),
                          ],
                        )),
                  )
                ],
              ),
              TextButton(
                  onPressed: () async {
                    if (event.imageID.isEmpty && event.detectType.contains(2)) {
                      debugPrint("画像トラッキングを使用するのに画像データが存在しません");
                      return;
                    }
                    final List<FileManager> modelList =
                        await FileDownloader().getfileURL(event.modelID, true);
                    if (modelList.length != event.modelID.length) {
                      debugPrint("エラー：モデルデータが足りていません");
                      return;
                    }
                    if (event.detectType.contains(2)) {
                      final List<FileManager> imageList = await FileDownloader()
                          .getfileURL(event.imageID, false);
                      if (imageList.length != event.imageID.length) {
                        debugPrint("エラー：画像データが足りていません");
                        return;
                      }
                      final bool getImage = await FileDownloader()
                          .fileDownloader(imageList, false);
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
                  },
                  child: const Text("データ取得"))
            ],
          )),
    );
  }
}
