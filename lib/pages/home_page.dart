import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memoria/backend/provider/booked_list.dart';
import 'package:memoria/backend/provider/favorite_list.dart';
import 'package:memoria/backend/provider/provider_event.dart';
import 'package:memoria/common/banner_card.dart';
import 'package:memoria/common/booked_card.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:memoria/common/favorite_card.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;

    final eventList = ref.watch(eventProvider);
    final favoriteList = ref.watch(favoriteListNotifierProvider);
    final bookedList = ref.watch(bookedListNotifierProvider);
    final infoCardTitle = useState("memoria(メモリア)へようこそ！");
    final infoCardCC = useState("イベントバナーをタップして\n入場、参加予定、いいねなどができます。   enjoy!");
    final infoCardDescription = useState("");

    return SingleChildScrollView(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: screenWidth / 8,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color.fromARGB(179, 235, 234, 238),
                      ),
                      margin: const EdgeInsets.only(top: 40),
                      padding: const EdgeInsets.only(top: 425),
                      height: 607,
                      width: 330,
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
                            text: TextSpan(
                                text: infoCardTitle.value,
                                style: const TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 28,
                                    height: 1.05),
                                children: <TextSpan>[
                              const TextSpan(text: "\n"),
                              TextSpan(
                                text: infoCardCC.value,
                                style: const TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 20,
                                    height: 1.4),
                              ),
                              const TextSpan(text: "\n"),
                              TextSpan(
                                text: infoCardDescription.value.length <= 56
                                    ? "\n${infoCardDescription.value.replaceAll('\\n', '\n')}"
                                    : "\n${infoCardDescription.value.replaceAll('\\n', '\n').substring(0, 55)}…",
                                style: const TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 16,
                                    height: 1.1),
                              ),
                            ])),
                      )),
                ),
                switch (eventList) {
                  AsyncData(:final value) => CarouselSlider.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index, realIndex) {
                        return BannerCard(event: value[index]);
                      },
                      options: CarouselOptions(
                        aspectRatio: 0.89,
                        autoPlayInterval: const Duration(seconds: 14),
                        //height: h, //高さ
                        //enlargeCenterPage: true,
                        //enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        initialPage: 0, //最初に表示されるページ
                        autoPlay: true, //自動でスライドしてくれるか
                        animateToClosest: false,
                        enlargeFactor: 1,
                        viewportFraction: 0.822, //各カードの表示される範囲の割合
                        enableInfiniteScroll: true, //最後のカードから最初のカードへの遷移
                        autoPlayAnimationDuration: const Duration(
                            milliseconds: 1000), //スライドが始まって終わるまでの時間),
                        onPageChanged: (index, reason) {
                          infoCardTitle.value = value[index].title;
                          infoCardCC.value = value[index].catchCopy;
                          infoCardDescription.value = value[index].description;
                        },
                      )),
                  AsyncError(:final error) => Text('Riverpod Error:$error'),
                  _ => const CircularProgressIndicator(),
                },
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 200)),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  initiallyExpanded: false,
                  maintainState: true,
                  expandedAlignment: Alignment.center,
                  backgroundColor: const Color.fromARGB(179, 235, 234, 238),
                  iconColor: Colors.teal[600],
                  collapsedIconColor: Colors.black54,
                  collapsedBackgroundColor:
                      const Color.fromARGB(179, 235, 234, 238),
                  minTileHeight: 70,
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: const Row(children: [
                    Icon(
                      Icons.bookmark_border,
                      size: 34,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text("参加予定", style: TextStyle(fontSize: 20)),
                  ]),
                  expandedCrossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: double.maxFinite,
                      height: 300,
                      child: favoriteList.isEmpty
                          ? const Text(
                              "参加予定は空っぽだよ",
                              style: TextStyle(height: 5, fontSize: 30),
                            )
                          : ListView.separated(
                              padding:
                                  const EdgeInsets.only(right: 100, left: 12),
                              scrollDirection: Axis.horizontal,
                              itemCount: bookedList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return BookedCard(event: bookedList[index]);
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 14,
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  initiallyExpanded: false,
                  maintainState: true,
                  expandedAlignment: Alignment.center,
                  backgroundColor: const Color.fromARGB(179, 235, 234, 238),
                  iconColor: Colors.redAccent,
                  collapsedIconColor: Colors.black54,
                  collapsedBackgroundColor:
                      const Color.fromARGB(179, 235, 234, 238),
                  minTileHeight: 70,
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: const Row(children: [
                    Icon(
                      Icons.favorite_border,
                      size: 34,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text("favorite", style: TextStyle(fontSize: 20)),
                  ]),
                  expandedCrossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      width: double.maxFinite,
                      height: 400,
                      child: favoriteList.isEmpty
                          ? const Text(
                              "favoriteは空っぽだよ",
                              style: TextStyle(height: 5, fontSize: 30),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 0.7,
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 4),
                              itemCount: favoriteList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FavoriteCard(
                                  event: favoriteList[index],
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 100))
          ],
        ));
    //);
  }
}
