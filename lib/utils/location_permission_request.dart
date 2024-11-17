import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:permission_handler/permission_handler.dart';

class RequestLocationPermission {
  static Future<PermissionStatus> request(Location location) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // 位置情報サービスのステータス確認
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      debugPrint("位置情報サービスのリクエストを行います…");
      serviceEnabled = await location.requestService(); // 許可されていない場合はリクエストを行う
      if (!serviceEnabled) {
        debugPrint("リクエストが拒否されました");
        return PermissionStatus.denied;
      }
    }

    // アプリに対しての位置情報権限の利用ステータスを確認
    permissionGranted = await Permission.locationWhenInUse.status;

    if (permissionGranted != PermissionStatus.granted) {
      debugPrint("フォアグラウンド時の位置情報使用のリクエストを行います…");
      await Permission.locationWhenInUse.request(); // 許可されていない場合はリクエストを行う
    }

    return permissionGranted;
  }
}
