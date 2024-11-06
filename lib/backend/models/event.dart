import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

//flutter pub run build_runner build --delete-conflicting-outputs
@freezed
class Event with _$Event {
  const Event._();
  const factory Event({
    @JsonKey(name: 'hostID') required int hostID,
    @JsonKey(name: 'eventID') required String eventID,
    @JsonKey(name: 'bannerURL') required String bannerURL,
    @JsonKey(name: 'mapURL') required String mapURL,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'catchCopy') required String catchCopy,
    @JsonKey(name: 'description') required String description,
    @JsonKey(name: 'location') required String location,
    @JsonKey(name: 'createdAt')
    @DateTimeConverter()
    required DateTime createdAt,
    @JsonKey(name: 'open') @DateTimeConverter() required DateTime open,
    @JsonKey(name: 'close') @DateTimeConverter() required DateTime close,
    @JsonKey(name: 'imageID') required List<int> imageID,
    @JsonKey(name: 'modelID') required List<int> modelID,
    @JsonKey(name: 'detectType') required List<int> detectType,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

class DateTimeConverter implements JsonConverter<DateTime, Timestamp> {
  const DateTimeConverter();

  @override
  DateTime fromJson(Timestamp json) {
    return json.toDate();
  }

  @override
  Timestamp toJson(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }
}
