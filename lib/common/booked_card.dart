import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memoria/backend/models/event.dart';
import 'package:memoria/pages/detail_page.dart';
import 'package:memoria/utils/weekday_converter.dart';

class BookedCard extends StatelessWidget {
  final Event event;
  const BookedCard({super.key, required this.event});
  @override
  Widget build(BuildContext context) {
    final List<String> eventLocation = event.location.split('/');
    return Stack(clipBehavior: Clip.none, children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      event: event,
                    )),
          );
        },
        child: Container(
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
                  child: CachedNetworkImage(
                    imageUrl: event.bannerURL,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                RichText(
                    text: TextSpan(
                        text: "${eventLocation[0]} ${eventLocation[1]}",
                        style: const TextStyle(
                            color: Color(0xff333333), fontSize: 16),
                        children: <TextSpan>[
                      TextSpan(
                        text:
                            "\n${event.open.year}/${event.open.month}/${event.open.day}(${getWeekDayJP(event.open.weekday)})",
                        style: const TextStyle(
                            color: Color(0xff333333), fontSize: 16),
                      ),
                    ]))
              ],
            )),
      ),
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

class FavoriteCard extends StatelessWidget {
  final Event event;
  const FavoriteCard({super.key, required this.event});
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
                MaterialPageRoute(
                    builder: (context) => DetailPage(
                          event: event,
                        )),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: event.bannerURL,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
              ),
            )));
  }
}
