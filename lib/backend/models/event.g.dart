// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
      hostID: (json['hostID'] as num).toInt(),
      areaRadius: (json['areaRadius'] as num).toDouble(),
      eventID: json['eventID'] as String,
      bannerURL: json['bannerURL'] as String,
      mapURL: json['mapURL'] as String,
      title: json['title'] as String,
      catchCopy: json['catchCopy'] as String,
      description: json['description'] as String,
      hostName: json['hostName'] as String,
      location: json['location'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as Timestamp),
      open: const DateTimeConverter().fromJson(json['open'] as Timestamp),
      close: const DateTimeConverter().fromJson(json['close'] as Timestamp),
      imageID: (json['imageID'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      modelID: (json['modelID'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      detectType: (json['detectType'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      geo: json['geo'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'hostID': instance.hostID,
      'areaRadius': instance.areaRadius,
      'eventID': instance.eventID,
      'bannerURL': instance.bannerURL,
      'mapURL': instance.mapURL,
      'title': instance.title,
      'catchCopy': instance.catchCopy,
      'description': instance.description,
      'hostName': instance.hostName,
      'location': instance.location,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'open': const DateTimeConverter().toJson(instance.open),
      'close': const DateTimeConverter().toJson(instance.close),
      'imageID': instance.imageID,
      'modelID': instance.modelID,
      'detectType': instance.detectType,
      'geo': instance.geo,
    };
