import 'package:cloud_firestore/cloud_firestore.dart';

class AppConst {
  static final db = FirebaseFirestore.instance;
}

class AppVar {
  final Map event = {
    "bannerURL": "noBannerURL",
    "catchCopy": "noCatchCopy", //
    "close": Timestamp.now(), //
    "createdAt": Timestamp.now(),
    "description": "noDescription", //
    "hostID": 0,
    "imageID": [0],
    "location": "noLocation", //
    "mapURL": "noMapURL",
    "madelID": [0],
    "open": Timestamp.now(), //
    "title": "noTitle", //
  };
}
