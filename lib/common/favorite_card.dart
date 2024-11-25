import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memoria/backend/models/event.dart';
import 'package:memoria/pages/detail_page.dart';

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
