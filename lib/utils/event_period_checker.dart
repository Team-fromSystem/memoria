import 'package:flutter/foundation.dart';
import 'package:memoria/backend/models/event.dart';

class EventPeriodChecker {
  static int checkOpening(Event event) {
    if (DateTime.now().compareTo(event.open) < 0) {
      debugPrint("まだ開催期間じゃないよ");
      return -1;
    }
    if (DateTime.now().compareTo(event.close) > 0) {
      debugPrint("もう開催期間は終了したよ");
      return 1;
    }
    debugPrint("イベントは開催中だよ");
    return 0;
  }
}
