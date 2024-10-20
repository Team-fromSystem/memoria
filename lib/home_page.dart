import 'package:memoria/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TestImage extends StatelessWidget {
  const TestImage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DetailPage()),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset('assets/images/natumaturi.jpeg'),
          ),
        ));
  }
}

class BookedCard extends StatelessWidget {
  const BookedCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
          width: 150,
          height: 264,
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
          margin: const EdgeInsets.only(top: 4),
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(95, 0, 0, 0),
                  offset: Offset(0, 2),
                  blurRadius: 3,
                  spreadRadius: 0.2,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset('assets/images/natumaturi.jpeg'),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              RichText(
                  text: const TextSpan(
                      text: " " + "location",
                      style: TextStyle(color: Color(0xff333333), fontSize: 18),
                      children: <TextSpan>[
                    TextSpan(text: "\n"),
                    TextSpan(
                      text: " " + "sub",
                      style: TextStyle(color: Color(0xff333333), fontSize: 18),
                    ),
                  ]))
            ],
          )),
      Positioned(
          top: 0,
          left: 70,
          child: Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(60),
            ),
            child: null,
          )),
    ]);
  }
}

class FavCard extends StatelessWidget {
  const FavCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset('assets/images/natumaturi.jpeg'),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    //double screenHeight = screenSize.height;
    //const double w = 340;
    //const h = w * 1.414;
    return

        //Scaffold(
        //body:

        SingleChildScrollView(
            padding: const EdgeInsets.only(top: 32),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: screenWidth / 7,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromARGB(179, 235, 234, 238),
                          ),
                          margin: const EdgeInsets.only(top: 40),
                          padding: const EdgeInsets.only(top: 425),
                          height: 600,
                          width: 315,
                          child: Container(
                            alignment: Alignment.topLeft,
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                            margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        width: 1, color: Color(0xff888888)))),
                            child: RichText(
                                text: const TextSpan(
                                    text: "title",
                                    style: TextStyle(
                                        color: Color(0xff333333), fontSize: 26),
                                    children: <TextSpan>[
                                  TextSpan(text: "\n"),
                                  TextSpan(
                                    text: "sub",
                                    style: TextStyle(
                                        color: Color(0xff333333), fontSize: 20),
                                  ),
                                  TextSpan(text: "\n"),
                                  TextSpan(
                                    text: "description",
                                    style: TextStyle(
                                        color: Color(0xff333333), fontSize: 16),
                                  ),
                                ])),
                          )),
                    ),
                    CarouselSlider(
                        items: const [
                          Card(
                            child: TestImage(),
                          ),
                          Card(
                            child: TestImage(),
                          ),
                          Card(
                            child: TestImage(),
                          ),
                          Card(
                            child: TestImage(),
                          ),
                        ],
                        options: CarouselOptions(
                          aspectRatio: 0.9,
                          //height: h, //高さ
                          //enlargeCenterPage: true,
                          //enlargeStrategy: CenterPageEnlargeStrategy.scale,
                          initialPage: 1, //最初に表示されるページ
                          autoPlay: false, //自動でスライドしてくれるか
                          //animateToClosest: false,
                          //enlargeFactor: 0,
                          viewportFraction: 0.8, //各カードの表示される範囲の割合
                          enableInfiniteScroll: true, //最後のカードから最初のカードへの遷移
                          autoPlayInterval:
                              const Duration(seconds: 5), //カードのインターバル
                          autoPlayAnimationDuration: const Duration(
                              milliseconds: 800), //スライドが始まって終わるまでの時間),
                        )),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 200)),
                Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(179, 235, 234, 238),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: screenWidth,
                    height: 344,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    padding: const EdgeInsets.only(left: 10, top: 16),
                    child: Column(
                      children: <Widget>[
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(children: [
                              Icon(
                                Icons.bookmark_border,
                                size: 34,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text("参加予定", style: TextStyle(fontSize: 20)),
                            ]),
                            IconButton(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 6),
                              onPressed: null,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 34,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          height: 270,
                          //color: Colors.red,
                          child: ListView.separated(
                            padding: const EdgeInsets.only(right: 100),
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            itemBuilder: (BuildContext context, int index) {
                              return const BookedCard();
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 14,
                              );
                            },
                          ),
                        ),
                      ],
                    )),
                Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(179, 235, 234, 238),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: screenWidth,
                    height: 500,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    padding: const EdgeInsets.only(left: 10, top: 16),
                    child: Column(
                      children: <Widget>[
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(children: [
                              Icon(
                                Icons.favorite_border,
                                size: 34,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text("favorite", style: TextStyle(fontSize: 20)),
                            ]),
                            IconButton(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 6),
                              onPressed: null,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 34,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          //color: Colors.black,
                          padding: const EdgeInsets.only(left: 6, right: 16),
                          width: double.maxFinite,
                          height: 400,
                          child: GridView.builder(
                            //padding: EdgeInsets.only(left: 10),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 0.7,
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 4),
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return const TestImage();
                            },
                          ),
                        ),
                      ],
                    )),
                //FavCard(),
              ],
            ));
    //);
  }
}
