import 'package:flutter/material.dart';
import 'package:memoria/home_page.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    //double screenHeight = screenSize.height;
    //const double w = 340;
    //const h = w * 1.414;
    return Scaffold(
      backgroundColor: const Color.fromARGB(253, 235, 234, 238),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 32),
          child: Column(
            children: [
              const TestImage(),
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
                          text: const TextSpan(
                              text: "EventTitle",
                              style: TextStyle(
                                  height: 1.5,
                                  color: Color(0xff333333),
                                  fontSize: 30),
                              children: <TextSpan>[
                            TextSpan(text: "\n"),
                            TextSpan(
                              text: "sub",
                              style: TextStyle(
                                  color: Color(0xff333333), fontSize: 26),
                            ),
                            TextSpan(text: "\n"),
                            TextSpan(
                              text: "description",
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 20,
                                  height: 2),
                            ),
                          ])),
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
                      RichText(
                          text: const TextSpan(
                              text: "大阪府",
                              style: TextStyle(
                                  height: 1.1,
                                  color: Color(0xff333333),
                                  fontSize: 26),
                              children: <TextSpan>[
                            TextSpan(text: "\n"),
                            TextSpan(
                              text: "高田市",
                              style: TextStyle(
                                  color: Color(0xff333333), fontSize: 26),
                            ),
                            TextSpan(text: "\n"),
                            TextSpan(
                              text: "大通り1丁目2-3",
                              style: TextStyle(
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
                      //width: screenWidth,
                      margin: const EdgeInsets.fromLTRB(10, 3, 5, 16),
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                              text: const TextSpan(
                                  text: "Open",
                                  style: TextStyle(
                                      height: 1.1,
                                      color: Color(0xff333333),
                                      fontSize: 26),
                                  children: <TextSpan>[
                                TextSpan(text: "\n"),
                                TextSpan(
                                  text: "8/17 (土曜日)",
                                  style: TextStyle(
                                      color: Color(0xff333333), fontSize: 24),
                                ),
                                TextSpan(text: "\n"),
                                TextSpan(
                                  text: "18:00 ~ 21:00",
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 22,
                                      height: 2),
                                ),
                              ])),
                        ],
                      )),
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
                      //width: screenWidth,
                      margin: const EdgeInsets.fromLTRB(5, 3, 10, 16),
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                              text: const TextSpan(
                                  text: "Close",
                                  style: TextStyle(
                                      height: 1.1,
                                      color: Color(0xff333333),
                                      fontSize: 26),
                                  children: <TextSpan>[
                                TextSpan(text: "\n"),
                                TextSpan(
                                  text: "8/17 (土曜日)",
                                  style: TextStyle(
                                      color: Color(0xff333333), fontSize: 24),
                                ),
                                TextSpan(text: "\n"),
                                TextSpan(
                                  text: "18:00 ~ 21:00",
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 22,
                                      height: 2),
                                ),
                              ])),
                        ],
                      )),
                ],
              )
            ],
          )),
    );
  }
}
