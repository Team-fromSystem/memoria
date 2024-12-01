import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:location/location.dart';
import 'package:memoria/backend/models/event.dart';

class GetLocation {
  static Future<LocationData> getPosition(Location location) async {
    final currentLocation = await location.getLocation();
    debugPrint('Date:${DateTime.now()}\nLocation:$currentLocation');
    return currentLocation;
  }

  static Future<List<String>> getNearbyEvents(
      GeoFirePoint centerPoint, double areaRadius) async {
    final db = FirebaseFirestore.instance;
    final CollectionReference collectionReference = db.collection('events');
    final List<DocumentSnapshot> snapshotList;
    final nearbyEventList = <String>[];

    try {
      snapshotList =
          await GeoCollectionReference(collectionReference).fetchWithin(
        center: centerPoint,
        radiusInKm: areaRadius / 1000,
        field: 'geo',
        geopointFrom: (data) => ((data as Map<String, dynamic>)['geo']
            as Map<String, dynamic>)['geoPoint'] as GeoPoint,
        strictMode: true,
      );
      for (var content in snapshotList) {
        nearbyEventList.add(content.get('eventID'));
        debugPrint(nearbyEventList[0]);
      }

      return nearbyEventList;
    } on FirebaseException catch (e) {
      debugPrint("$e");
      throw e.toString();
    }
  }

  static Future<bool> checkEventArea(Location location, Event event) async {
    final LocationData centerLocationData = await getPosition(location);

    if (centerLocationData.isMock == true) {
      debugPrint("位置情報についてmockが検出されました");
      return false;
    }
    final GeoFirePoint centerGeoFirePoint = GeoFirePoint(GeoPoint(
        centerLocationData.latitude ?? 0.0,
        centerLocationData.longitude ?? 0.0));
    debugPrint(
        "${centerGeoFirePoint.data['geopoint'].latitude}\n${centerGeoFirePoint.data['geopoint'].longitude}");
    final nearbyEventList =
        await getNearbyEvents(centerGeoFirePoint, event.areaRadius);

    if (nearbyEventList.isEmpty) {
      debugPrint("どのイベントの開催エリア内でもない");
      return false;
    }
    if (nearbyEventList.where((value) => value == event.eventID).isEmpty) {
      debugPrint("該当イベントではないイベントの開催エリア内");
      return false;
    }
    debugPrint("該当イベントの範囲内");
    return true;
  }
}
