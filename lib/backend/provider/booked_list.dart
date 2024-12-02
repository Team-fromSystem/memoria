import 'package:flutter/material.dart';
import 'package:memoria/backend/models/event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'booked_list.g.dart';

// dart pub run build_runner build --delete-conflicting-outputs
@riverpod
class BookedListNotifier extends _$BookedListNotifier {
  @override
  List<Event> build() {
    return [];
  }

  void toggleBooking(Event event, BuildContext context) {
    final oldState = state;
    if (oldState.contains(event)) {
      // 新しいリストを作成し、該当のイベントを除外
      final newState = oldState.where((value) => value != event).toList();
      state = newState; // 直接stateを更新
      debugPrint("${event.title} is deleted!\nitems:${newState.length}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 1000),
          content: Text("${event.title} が参加予定リストから削除されました")));
    } else {
      // イベントが存在しない場合は追加
      final newState = [...oldState, event];
      state = newState;
      debugPrint("${event.title} is added!\nitems:${newState.length}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 1000),
          content: Text("${newState.last.title} が参加予定リストに追加されました！")));
    }
  }
}
