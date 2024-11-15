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

  static Future<bool> checkEventArea(Location location, Event event) async {
    LocationData centerLocationData = await getPosition(location);
    GeoFirePoint geoFirePoint = GeoFirePoint(event.geo['geoPoint']);

    if (centerLocationData.isMock == true) {
      debugPrint("位置情報についてmockが検出されました");
      return false;
    } else {
      final GeoFirePoint centerGeoPoint = GeoFirePoint(GeoPoint(
          centerLocationData.latitude ?? 0.0,
          centerLocationData.longitude ?? 0.0));
      return true;
    }
  }
}
