import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:memoria/backend/fileDownloader/fileDownloader.dart';
import 'package:memoria/backend/models/event.dart';
import 'package:memoria/common/dialogs.dart';
import 'package:memoria/utils/location_checker.dart';
import 'package:memoria/utils/location_permission_request.dart';
import 'package:memoria/utils/weekday_converter.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailPage extends StatelessWidget {
  final Event event;
  const DetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final List<String> eventLocation = event.location.split('/');
    final Location location = Location();
    return Scaffold(
      backgroundColor: const Color.fromARGB(253, 235, 234, 238),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("イベント詳細"),
        titleTextStyle: const TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(252, 235, 234, 238),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
          ),
        ),
        toolbarHeight: 70,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          CircleAvatar(
            radius: 28,
            child: IconButton(
                iconSize: 32,
                onPressed: () async {
                  await Dialogs.checkFile(context, event);
                },
                icon: const Icon(CupertinoIcons.cloud_download)),
          ),
          const Padding(padding: EdgeInsets.only(right: 8)),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0.1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(50),
            ),
            child: AnimatedButton(
              width: 90,
              height: 54,
              borderRadius: 50,
              text: '入場！',
              textStyle: const TextStyle(
                  height: -0.1,
                  fontSize: 17,
                  letterSpacing: 2,
                  color: Color.fromARGB(205, 0, 0, 0),
                  fontWeight: FontWeight.w100),
              animationDuration: const Duration(milliseconds: 800),
              selectedTextColor: Colors.black,
              transitionType: TransitionType.LEFT_TOP_ROUNDER,
              //backgroundColor: const Color.fromARGB(255, 171, 242, 220),
              gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [
                  const Color(0xff9941d8).withOpacity(0.7),
                  const Color.fromARGB(255, 171, 242, 220),
                ],
              ),
              selectedGradientColor: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [
                  const Color(0xffe4a972).withOpacity(0.8),
                  const Color(0xff9941d8).withOpacity(0.8),
                ],
              ),
              onPress: () {},
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 10)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 5.0,
          child: const Icon(Icons.camera),
          onPressed: () async {
            if (await RequestLocationPermission.request(location).isDenied) {
              await showDialog(
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
              return;
            }
            if (!await GetLocation.checkEventArea(location, event)) {
              debugPrint("イベント範囲外です");
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('このイベントの開催エリア外です'),
                    content: const Text('AR'),
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
              return;
            } else {
              debugPrint("unityWidgetへ");
              //TODO unityWidgetへ遷移
            }
          }),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 100),
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
                  child: const Text("データ取得")),
              Card(
                elevation: 20.0,
                child: AnimatedButton(
                  width: 200,
                  height: 70,
                  borderRadius: 12,
                  text: 'イベントに入場！',
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
                  textStyle: GoogleFonts.nunito(
                      fontSize: 18,
                      letterSpacing: 5,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  onPress: () {},
                ),
              ),
            ],
          )),
    );
  }
}
