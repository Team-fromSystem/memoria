import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/cupertino.dart';
import 'package:memoria/utils/weekday_converter.dart';

class RegisterPage extends HookWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    final db = FirebaseFirestore.instance;
    final nowDateTime = DateTime.now();
    final openDateTime = useState<DateTime>(nowDateTime);
    final closeDateTime = useState<DateTime>(nowDateTime);
    final controllerTitle = useTextEditingController();
    final controllerCC = useTextEditingController();
    final controllerHN = useTextEditingController();
    final controllerDescription = useTextEditingController();
    final controllerLocation1 = useTextEditingController();
    final controllerLocation2 = useTextEditingController();
    final controllerLocation3 = useTextEditingController();

    Map<String, dynamic> newEvent(
        String newTitle,
        String newCatchCopy,
        String newHostName,
        String newDescription,
        String newLocation,
        DateTime openDateTime,
        DateTime closeDateTime) {
      Timestamp openTime = Timestamp.fromDate(openDateTime);
      Timestamp closeTime = Timestamp.fromDate(closeDateTime);
      final Map<String, dynamic> geoMap = {
        "geoPoint": const GeoPoint(0, 0),
        "geohash": "nohash",
      };

      final Map<String, dynamic> newEvent = {
        "bannerURL": "noBannerURL",
        "catchCopy": newCatchCopy, //
        "close": closeTime, //
        "createdAt": Timestamp.now(),
        "description": newDescription, //
        "hostID": 0,
        "imageID": [0],
        "location": newLocation, //
        "mapURL": "noMapURL",
        "modelID": [0],
        "open": openTime, //
        "title": newTitle, //
        "detectType": [0],
        "geo": geoMap,
      };

      return newEvent;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("イベント登録ページ"),
      ),
      backgroundColor: const Color.fromARGB(253, 235, 234, 238),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save_as_rounded),
          onPressed: () async {
            String newLocation =
                " ${controllerLocation1.text}/${controllerLocation2.text}/${controllerLocation3.text}";
            DocumentReference docRef = await db.collection("events").add(
                newEvent(
                    controllerTitle.text,
                    controllerCC.text,
                    controllerHN.text,
                    controllerDescription.text,
                    newLocation,
                    openDateTime.value,
                    closeDateTime.value));
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
          }),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 32),
          child: Column(
            children: [
              //const TestImage(),
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
                      TextField(
                        style: const TextStyle(
                            height: 1.5,
                            color: Color(0xff333333),
                            fontSize: 30),
                        decoration:
                            const InputDecoration(labelText: "イベントタイトル"),
                        controller: controllerTitle,
                      ),
                      TextField(
                        style: const TextStyle(
                            color: Color(0xff333333), fontSize: 26),
                        decoration: const InputDecoration(labelText: "キャッチコピー"),
                        controller: controllerCC,
                      ),
                      const TextField(
                        style:
                            TextStyle(color: Color(0xff333333), fontSize: 26),
                        decoration: InputDecoration(labelText: "主催者"),
                      ),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: const TextStyle(
                            color: Color(0xff333333), fontSize: 17),
                        decoration: const InputDecoration(labelText: "イベント説明"),
                        controller: controllerDescription,
                      ),
                      const Divider(
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
                      TextField(
                        style: const TextStyle(
                            height: 1.5,
                            color: Color(0xff333333),
                            fontSize: 26),
                        decoration: const InputDecoration(labelText: "都道府県"),
                        controller: controllerLocation1,
                      ),
                      TextField(
                        style: const TextStyle(
                            //height: 1.5,
                            color: Color(0xff333333),
                            fontSize: 26),
                        decoration: const InputDecoration(labelText: "市区町村"),
                        controller: controllerLocation2,
                      ),
                      TextField(
                        style: const TextStyle(
                            color: Color(0xff333333), fontSize: 22),
                        decoration: const InputDecoration(labelText: "住所"),
                        controller: controllerLocation3,
                      ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    text: "\n\n↓日付を入力\n",
                                    style: TextStyle(
                                        color: Color(0xff777777), fontSize: 14),
                                  ),
                                  TextSpan(
                                    text:
                                        "${openDateTime.value.year}年\n${openDateTime.value.month}/${openDateTime.value.day} (${getWeekDayJP(openDateTime.value.weekday)})",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        showCupertinoModalPopup<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return _buildBottomPicker(
                                              CupertinoDatePicker(
                                                use24hFormat: true,
                                                minimumYear: 2024,
                                                //minimumDate: nowDateTime,
                                                showDayOfWeek: true,
                                                mode: CupertinoDatePickerMode
                                                    .date,
                                                initialDateTime:
                                                    openDateTime.value,
                                                onDateTimeChanged:
                                                    (DateTime newDateTime) {
                                                  openDateTime.value =
                                                      newDateTime;
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    style: const TextStyle(
                                        height: 1.2,
                                        color: Color(0xff333333),
                                        fontSize: 24),
                                  ),
                                  const TextSpan(
                                    text: "\n\n↓時刻を入力\n",
                                    style: TextStyle(
                                        color: Color(0xff777777), fontSize: 14),
                                  ),
                                  TextSpan(
                                    text:
                                        "${openDateTime.value.hour}:${openDateTime.value.minute} ~ ",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        showCupertinoModalPopup<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return _buildBottomPicker(
                                              CupertinoDatePicker(
                                                use24hFormat: true,
                                                mode: CupertinoDatePickerMode
                                                    .time,
                                                initialDateTime:
                                                    openDateTime.value,
                                                onDateTimeChanged:
                                                    (DateTime newDateTime) {
                                                  openDateTime.value =
                                                      newDateTime;
                                                  // }
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    style: const TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 22,
                                        height: 1.5),
                                  ),
                                  TextSpan(
                                    text:
                                        "${closeDateTime.value.hour}:${closeDateTime.value.minute}",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        //print('"RichText" がタップされました');
                                        showCupertinoModalPopup<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return _buildBottomPicker(
                                              CupertinoDatePicker(
                                                use24hFormat: true,
                                                mode: CupertinoDatePickerMode
                                                    .time,
                                                initialDateTime:
                                                    closeDateTime.value,
                                                onDateTimeChanged:
                                                    (DateTime newDateTime) {
                                                  closeDateTime.value =
                                                      newDateTime;
                                                  // }
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    style: const TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 22,
                                        height: 1.5),
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
                                    text: "\n\n↓日付を入力\n",
                                    style: TextStyle(
                                        color: Color(0xff777777), fontSize: 14),
                                  ),
                                  TextSpan(
                                    text:
                                        "${closeDateTime.value.year}年\n${closeDateTime.value.month}/${closeDateTime.value.day} (${getWeekDayJP(closeDateTime.value.weekday)})",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        showCupertinoModalPopup<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return _buildBottomPicker(
                                              CupertinoDatePicker(
                                                  use24hFormat: true,
                                                  minimumYear: 2024,
                                                  //minimumDate: nowDateTime,
                                                  showDayOfWeek: true,
                                                  mode: CupertinoDatePickerMode
                                                      .date,
                                                  initialDateTime:
                                                      closeDateTime.value,
                                                  onDateTimeChanged:
                                                      (DateTime newDateTime) {
                                                    closeDateTime.value =
                                                        newDateTime;
                                                  }),
                                            );
                                          },
                                        );
                                      },
                                    style: const TextStyle(
                                        height: 1.2,
                                        color: Color(0xff333333),
                                        fontSize: 24),
                                  ),
                                  const TextSpan(
                                    text: "\n\n\n",
                                    style: TextStyle(
                                        color: Color(0xff777777), fontSize: 14),
                                  ),
                                  TextSpan(
                                    text:
                                        "${openDateTime.value.hour}:${openDateTime.value.minute} ~ ${closeDateTime.value.hour}:${closeDateTime.value.minute}",
                                    style: const TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 22,
                                        height: 1.5),
                                  ),
                                ])),
                          ],
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 300,
              )
            ],
          )),
    );
  }
}

double _kPickerSheetHeight = 260.0;
Widget _buildBottomPicker(Widget picker) {
  return Container(
    height: _kPickerSheetHeight,
    padding: const EdgeInsets.only(top: 6.0),
    color: CupertinoColors.white,
    child: DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.black,
        fontSize: 22.0,
      ),
      child: GestureDetector(
        // Blocks taps from propagating to the modal sheet and popping.
        onTap: () {},
        child: SafeArea(
          top: false,
          child: picker,
        ),
      ),
    ),
  );
}
