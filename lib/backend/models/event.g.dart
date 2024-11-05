// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
      hostID: (json['hostID'] as num).toInt(),
      bannerURL: json['bannerURL'] as String,
      mapURL: json['mapURL'] as String,
      title: json['title'] as String,
      catchCopy: json['catchCopy'] as String,
      description: json['description'] as String,
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
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'hostID': instance.hostID,
      'bannerURL': instance.bannerURL,
      'mapURL': instance.mapURL,
      'title': instance.title,
      'catchCopy': instance.catchCopy,
      'description': instance.description,
      'location': instance.location,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'open': const DateTimeConverter().toJson(instance.open),
      'close': const DateTimeConverter().toJson(instance.close),
      'imageID': instance.imageID,
      'modelID': instance.modelID,
      'detectType': instance.detectType,
    };
