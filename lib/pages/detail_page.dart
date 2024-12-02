import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';
import 'package:memoria/backend/fileDownloader/fileDownloader.dart';
import 'package:memoria/backend/models/event.dart';
import 'package:memoria/backend/provider/booked_list.dart';
import 'package:memoria/backend/provider/favorite_list.dart';
import 'package:memoria/common/dialogs.dart';
import 'package:memoria/common/image_viewer_overlay.dart';
import 'package:memoria/pages/google_map_page.dart';
import 'package:memoria/utils/event_period_checker.dart';
import 'package:memoria/utils/location_checker.dart';
import 'package:memoria/utils/location_permission_request.dart';
import 'package:memoria/utils/notification.dart';
import 'package:memoria/utils/weekday_converter.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailPage extends HookConsumerWidget {
  final Event event;
  const DetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final List<String> eventLocation = event.location.split('/');
    final Location location = Location();
    final OverlayPortalController overlayPortalController =
        OverlayPortalController();
    final favoriteList = ref.watch(favoriteListNotifierProvider);
    final bookedList = ref.watch(bookedListNotifierProvider);
    final isMapImage = useState<bool>(false);

    final LatLng eventLatLng =
        LatLng(event.geo['geoPoint'].latitude, event.geo['geoPoint'].longitude);

    late GoogleMapController mapController;
    final PageController mapPageCon = PageController();
    final isGoogleMap = useState(true);

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
                  final bool isFilesExist = await FileDownloader()
                      .checkFilesExist(event.modelID, event.imageID);
                  await Dialogs.fileChecker(context, event, isFilesExist);
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
              isReverse: true,
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
              animationDuration: const Duration(milliseconds: 2500),
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
              onPress: () async {
                final bool isFilesExist = await FileDownloader()
                    .checkFilesExist(event.modelID, event.imageID);
                final bool isRequeatGranted =
                    await RequestLocationPermission.request(location).isGranted;
                final bool isInsideArea =
                    await GetLocation.checkEventArea(location, event);
                await Dialogs.arChecker(
                    context, isFilesExist, isRequeatGranted, isInsideArea);
              },
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 10)),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
              heroTag: 'uniqueTag1',
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: bookedList.any((value) => value == event)
                  ? Icon(size: 34, color: Colors.teal[600], Icons.bookmark)
                  : const Icon(size: 32, Icons.bookmark_add_outlined),
              onPressed: () async {
                final List<ActiveNotification> activeNotifications =
                    await flutterLocalNotificationsPlugin
                        .getActiveNotifications();
                final List<PendingNotificationRequest>
                    pendingNotificationRequests =
                    await flutterLocalNotificationsPlugin
                        .pendingNotificationRequests();
                debugPrint(
                    "activeNotifications:${activeNotifications.length}\n\n\n");
                debugPrint(
                    "pendingNotificationRequests:${pendingNotificationRequests.length}\n\n\n");
                final bookedNotifier =
                    ref.read(bookedListNotifierProvider.notifier);
                bookedNotifier.toggleBooking(event, context);
                if (EventPeriodChecker.checkOpening(event) == -1) {
                  if (!pendingNotificationRequests
                      .any((value) => value.id == event.open.hashCode)) {
                    Dialogs.applyNotification(context, event.open, event.title);
                  } else {
                    Dialogs.deleteNotification(
                        context, event.open.hashCode, event.title);
                  }
                }
              }),
          const Padding(padding: EdgeInsets.only(top: 16)),
          FloatingActionButton(
              heroTag: 'uniqueTag2',
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: favoriteList.any((value) => value == event)
                  ? const Icon(size: 34, color: Colors.red, Icons.favorite)
                  : const Icon(size: 32, Icons.favorite_border),
              onPressed: () {
                final favNotifier =
                    ref.read(favoriteListNotifierProvider.notifier);
                favNotifier.toggleFavorite(event, context);
              }),
          const Padding(padding: EdgeInsets.only(top: 40)),
        ],
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
              ImageViewerOverlay(
                  imageURL: isMapImage.value ? event.mapURL : event.bannerURL,
                  controller: overlayPortalController,
                  lootContext: context),
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
                    onTap: () {
                      isMapImage.value = false;
                      overlayPortalController.show();
                    },
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
                margin: const EdgeInsets.only(right: 18, top: 2),
                alignment: Alignment.topRight,
                child: const Text(
                  "TAPで拡大",
                  style: TextStyle(
                      fontSize: 12, color: Color.fromARGB(255, 140, 140, 144)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 18, top: 0),
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
                              style: TextStyle(
                                  fontFamily: "${GoogleFonts.kiwiMaru}",
                                  height: 1.6,
                                  color: const Color(0xff333333),
                                  fontSize: 30),
                              children: <TextSpan>[
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
                            TextSpan(
                              text: "主催： ${event.hostName}\n\n",
                              style: const TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 18,
                                  height: 1.3),
                            ),
                            TextSpan(
                              text: event.description.replaceAll('\\n', '\n'),
                              style: const TextStyle(
                                color: Color(0xff333333),
                                fontSize: 16,
                                height: 1.5,
                              ),
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
                  child: Column(
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.only(
                              left: 20, top: 16, right: 20),
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
                                          color: Color(0xff333333),
                                          fontSize: 26),
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
                            ],
                          )),
                      Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          initiallyExpanded: false,
                          maintainState: true,
                          expandedAlignment: Alignment.center,
                          backgroundColor: Colors.white,
                          iconColor: Colors.teal[600],
                          collapsedIconColor: Colors.black54,
                          collapsedBackgroundColor: Colors.white,
                          minTileHeight: 54,
                          collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 6,
                                ),
                                Text("会場付近のmapを表示",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(
                                            255, 140, 140, 144))),
                              ]),
                          expandedCrossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 4, 10, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(CupertinoIcons.left_chevron,
                                            size: 24,
                                            color: isGoogleMap.value
                                                ? const Color.fromARGB(
                                                    255, 140, 140, 144)
                                                : const Color.fromARGB(
                                                    255, 66, 66, 67)),
                                        GestureDetector(
                                          onTap: () {
                                            mapPageCon.animateToPage(0,
                                                duration: const Duration(
                                                    milliseconds: 400),
                                                curve: Curves.ease);
                                          },
                                          child: Text(
                                            "GoogleMap",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: isGoogleMap.value
                                                  ? const Color.fromARGB(
                                                      255, 140, 140, 144)
                                                  : const Color.fromARGB(
                                                      255, 66, 66, 67),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            mapPageCon.animateToPage(1,
                                                duration: const Duration(
                                                    milliseconds: 400),
                                                curve: Curves.ease);
                                          },
                                          child: Text(
                                            "ImageMap",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: isGoogleMap.value
                                                  ? const Color.fromARGB(
                                                      255, 66, 66, 67)
                                                  : const Color.fromARGB(
                                                      255, 140, 140, 144),
                                            ),
                                          ),
                                        ),
                                        Icon(CupertinoIcons.right_chevron,
                                            size: 24,
                                            color: isGoogleMap.value
                                                ? const Color.fromARGB(
                                                    255, 66, 66, 67)
                                                : const Color.fromARGB(
                                                    255, 140, 140, 144)),
                                      ],
                                    ),
                                  ],
                                )),
                            Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                width: double.maxFinite,
                                height: 440,
                                child: PageView(
                                  controller: mapPageCon,
                                  onPageChanged: (value) {
                                    value == 0
                                        ? isGoogleMap.value = true
                                        : isGoogleMap.value = false;
                                  },
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 380,
                                          child: GoogleMap(
                                            rotateGesturesEnabled: false,
                                            scrollGesturesEnabled: false,
                                            tiltGesturesEnabled: false,
                                            initialCameraPosition:
                                                CameraPosition(
                                                    target: eventLatLng,
                                                    zoom: 7.5),
                                            myLocationEnabled: false,
                                            myLocationButtonEnabled: false,
                                            mapType: MapType.normal,
                                            zoomGesturesEnabled: false,
                                            zoomControlsEnabled: true,
                                            onMapCreated: (GoogleMapController
                                                controller) {
                                              mapController = controller;
                                            },
                                            onTap: (LatLng latlng) {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        GoogleMapPage(
                                                          geoPoint: event
                                                              .geo['geoPoint'],
                                                          areaRadius:
                                                              event.areaRadius,
                                                        )),
                                              );
                                            },
                                            markers: {
                                              Marker(
                                                markerId:
                                                    const MarkerId('marker_1'),
                                                position: eventLatLng,
                                              ),
                                            },
                                            circles: {
                                              Circle(
                                                circleId:
                                                    const CircleId('circle_1'),
                                                center: eventLatLng,
                                                radius: event.areaRadius,
                                                fillColor: const Color.fromARGB(
                                                        255, 136, 212, 185)
                                                    .withOpacity(0.3),
                                                strokeWidth: 1,
                                              ),
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        isMapImage.value = true;
                                        overlayPortalController.show();
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CachedNetworkImage(
                                          imageUrl: event.mapURL,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      )
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
            ],
          )),
    );
  }
}
