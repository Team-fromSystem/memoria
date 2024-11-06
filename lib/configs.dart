import 'package:cloud_firestore/cloud_firestore.dart';

class AppConst {
  static final db = FirebaseFirestore.instance;
}

// class Event {
//   int hostID;
//   String bannerURL;
//   String mapURL;
//   String title;
//   String catchCopy;
//   String description;
//   DateTime createdAt;
//   DateTime open;
//   DateTime close;
//   List<String> location;
//   List<dynamic> imageID;
//   List<dynamic> modelID;
//   Event(
//     this.hostID,
//     this.bannerURL,
//     this.mapURL,
//     this.title,
//     this.catchCopy,
//     this.description,
//     this.createdAt,
//     this.open,
//     this.close,
//     this.location,
//     this.imageID,
//     this.modelID,
//   );
//   static Event convertMapToEvent(Map<String, dynamic> eventMap) {
//     return Event(
//       eventMap['hostID'] as int,
//       eventMap['bannerURL'] as String,
//       eventMap['mapURL'] as String,
//       eventMap['title'] as String,
//       eventMap['catchCopy'] as String,
//       eventMap['description'] as String,
//       eventMap['createdAt'].toDate(),
//       eventMap['open'].toDate(),
//       eventMap['close'].toDate(),
//       eventMap['location'].split('/') as List<String>,
//       eventMap['imageID'] as List<dynamic>,
//       eventMap['modelID'] as List<dynamic>,
//     );
//   }
// }

String getWeekDayJP(int num) {
  switch (num) {
    case 1:
      return "月";
    case 2:
      return "火";
    case 3:
      return "水";
    case 4:
      return "木";
    case 5:
      return "金";
    case 6:
      return "土";
    case 7:
      return "日";
    default:
      throw Exception("not weekDays");
  }
}
