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
    double screenHeight = screenSize.height;

    final eventList = ref.watch(eventProvider);
    final favoriteList = ref.watch(favoriteListNotifierProvider);
    final bookedList = ref.watch(bookedListNotifierProvider);
    final currentEventIndex = useState<int>(0);

    return SingleChildScrollView(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          children: [
            switch (eventList) {
              AsyncData(:final value) => Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: screenWidth / 8,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromARGB(255, 238, 238, 238),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(40, 0, 0, 0),
                                offset: Offset(0, 3),
                                blurRadius: 3,
                                spreadRadius: 1.2,
                              )
                            ]),
                        margin: EdgeInsets.only(
                            top: screenHeight / 24, left: 0, right: 0),
                        padding: EdgeInsets.only(
                            top: (screenHeight * 2 / 3) * 3 / 4),
                        height: screenHeight * 31 / 48,
                        width: screenWidth * 4 / 5,
                      ),
                    ),
                    Positioned(
                        child: Column(
                      children: <Widget>[
                        CarouselSlider.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index, realIndex) {
                              return BannerCard(event: value[index]);
                            },
                            options: CarouselOptions(
                              aspectRatio: 0.89,
                              autoPlayInterval: const Duration(seconds: 14),
                              initialPage: 0,
                              autoPlay: true,
                              animateToClosest: false,
                              enlargeFactor: 1,
                              viewportFraction: 0.822,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 1000),
                              onPageChanged: (index, reason) {
                                currentEventIndex.value = index;
                              },
                            )),
                        Container(
                            alignment: Alignment.topLeft,
                            height: screenHeight / 6,
                            padding: const EdgeInsets.fromLTRB(6, 8, 6, 6),
                            margin: EdgeInsets.fromLTRB(
                                screenWidth / 8, 4, screenWidth / 14, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Divider(
                                    height: 1, color: Color(0xff888888)),
                                const Padding(
                                    padding: EdgeInsets.only(top: 10)),
                                Text(value[currentEventIndex.value].title,
                                    style: const TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 28,
                                        height: 1.05)),
                                FittedBox(
                                  child: Flexible(
                                    child: Text(
                                        value[currentEventIndex.value]
                                            .catchCopy,
                                        style: const TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: 20,
                                            height: 1.4)),
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  value[currentEventIndex.value]
                                      .description
                                      .replaceAll('\\n', '\n'),
                                  overflow: TextOverflow.fade,
                                  //maxLines: 3
                                ))
                              ],
                            ))
                      ],
                    ))
                  ],
                ),
              AsyncError(:final error) => Text('Riverpod Error:$error'),
              _ => const CircularProgressIndicator(),
            },
            Padding(padding: EdgeInsets.only(top: screenHeight / 18)),
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
                      height: 286,
                      child: favoriteList.isEmpty
                          ? const FittedBox(
                              child: Expanded(
                                  child: Text(
                              "イベントは未登録です…",
                              style: TextStyle(height: 5, fontSize: 30),
                            )))
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
                          ? const FittedBox(
                              child: Expanded(
                                  child: Text(
                              "イベントは未登録です…",
                              style: TextStyle(height: 5, fontSize: 30),
                            )))
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
  }
}
