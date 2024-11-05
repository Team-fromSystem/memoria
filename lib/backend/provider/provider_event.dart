import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memoria/backend/models/event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
//dart run build_runner watch

final eventProvider = FutureProvider<List<Event>>((ref) async {
  final db = FirebaseFirestore.instance;
  try {
    final snapShot = await db.collection('events').get();
    final eventList = <Event>[];
    for (var content in snapShot.docs) {
      eventList.add(Event.fromJson(content.data()));
    }
    return eventList;
  } on FirebaseException catch (e) {
    throw e.toString();
  }
});
