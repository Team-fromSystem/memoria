// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  @JsonKey(name: 'hostID')
  int get hostID => throw _privateConstructorUsedError;
  @JsonKey(name: 'bannerURL')
  String get bannerURL => throw _privateConstructorUsedError;
  @JsonKey(name: 'mapURL')
  String get mapURL => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'catchCopy')
  String get catchCopy => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'location')
  String get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  @DateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'open')
  @DateTimeConverter()
  DateTime get open => throw _privateConstructorUsedError;
  @JsonKey(name: 'close')
  @DateTimeConverter()
  DateTime get close => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageID')
  List<int> get imageID => throw _privateConstructorUsedError;
  @JsonKey(name: 'modelID')
  List<int> get modelID => throw _privateConstructorUsedError;
  @JsonKey(name: 'detectType')
  List<int> get detectType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call(
      {@JsonKey(name: 'hostID') int hostID,
      @JsonKey(name: 'bannerURL') String bannerURL,
      @JsonKey(name: 'mapURL') String mapURL,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'catchCopy') String catchCopy,
      @JsonKey(name: 'description') String description,
      @JsonKey(name: 'location') String location,
      @JsonKey(name: 'createdAt') @DateTimeConverter() DateTime createdAt,
      @JsonKey(name: 'open') @DateTimeConverter() DateTime open,
      @JsonKey(name: 'close') @DateTimeConverter() DateTime close,
      @JsonKey(name: 'imageID') List<int> imageID,
      @JsonKey(name: 'modelID') List<int> modelID,
      @JsonKey(name: 'detectType') List<int> detectType});
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hostID = null,
    Object? bannerURL = null,
    Object? mapURL = null,
    Object? title = null,
    Object? catchCopy = null,
    Object? description = null,
    Object? location = null,
    Object? createdAt = null,
    Object? open = null,
    Object? close = null,
    Object? imageID = null,
    Object? modelID = null,
    Object? detectType = null,
  }) {
    return _then(_value.copyWith(
      hostID: null == hostID
          ? _value.hostID
          : hostID // ignore: cast_nullable_to_non_nullable
              as int,
      bannerURL: null == bannerURL
          ? _value.bannerURL
          : bannerURL // ignore: cast_nullable_to_non_nullable
              as String,
      mapURL: null == mapURL
          ? _value.mapURL
          : mapURL // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      catchCopy: null == catchCopy
          ? _value.catchCopy
          : catchCopy // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as DateTime,
      close: null == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageID: null == imageID
          ? _value.imageID
          : imageID // ignore: cast_nullable_to_non_nullable
              as List<int>,
      modelID: null == modelID
          ? _value.modelID
          : modelID // ignore: cast_nullable_to_non_nullable
              as List<int>,
      detectType: null == detectType
          ? _value.detectType
          : detectType // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventImplCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$EventImplCopyWith(
          _$EventImpl value, $Res Function(_$EventImpl) then) =
      __$$EventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'hostID') int hostID,
      @JsonKey(name: 'bannerURL') String bannerURL,
      @JsonKey(name: 'mapURL') String mapURL,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'catchCopy') String catchCopy,
      @JsonKey(name: 'description') String description,
      @JsonKey(name: 'location') String location,
      @JsonKey(name: 'createdAt') @DateTimeConverter() DateTime createdAt,
      @JsonKey(name: 'open') @DateTimeConverter() DateTime open,
      @JsonKey(name: 'close') @DateTimeConverter() DateTime close,
      @JsonKey(name: 'imageID') List<int> imageID,
      @JsonKey(name: 'modelID') List<int> modelID,
      @JsonKey(name: 'detectType') List<int> detectType});
}

/// @nodoc
class __$$EventImplCopyWithImpl<$Res>
    extends _$EventCopyWithImpl<$Res, _$EventImpl>
    implements _$$EventImplCopyWith<$Res> {
  __$$EventImplCopyWithImpl(
      _$EventImpl _value, $Res Function(_$EventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hostID = null,
    Object? bannerURL = null,
    Object? mapURL = null,
    Object? title = null,
    Object? catchCopy = null,
    Object? description = null,
    Object? location = null,
    Object? createdAt = null,
    Object? open = null,
    Object? close = null,
    Object? imageID = null,
    Object? modelID = null,
    Object? detectType = null,
  }) {
    return _then(_$EventImpl(
      hostID: null == hostID
          ? _value.hostID
          : hostID // ignore: cast_nullable_to_non_nullable
              as int,
      bannerURL: null == bannerURL
          ? _value.bannerURL
          : bannerURL // ignore: cast_nullable_to_non_nullable
              as String,
      mapURL: null == mapURL
          ? _value.mapURL
          : mapURL // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      catchCopy: null == catchCopy
          ? _value.catchCopy
          : catchCopy // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as DateTime,
      close: null == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageID: null == imageID
          ? _value._imageID
          : imageID // ignore: cast_nullable_to_non_nullable
              as List<int>,
      modelID: null == modelID
          ? _value._modelID
          : modelID // ignore: cast_nullable_to_non_nullable
              as List<int>,
      detectType: null == detectType
          ? _value._detectType
          : detectType // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventImpl extends _Event {
  const _$EventImpl(
      {@JsonKey(name: 'hostID') required this.hostID,
      @JsonKey(name: 'bannerURL') required this.bannerURL,
      @JsonKey(name: 'mapURL') required this.mapURL,
      @JsonKey(name: 'title') required this.title,
      @JsonKey(name: 'catchCopy') required this.catchCopy,
      @JsonKey(name: 'description') required this.description,
      @JsonKey(name: 'location') required this.location,
      @JsonKey(name: 'createdAt') @DateTimeConverter() required this.createdAt,
      @JsonKey(name: 'open') @DateTimeConverter() required this.open,
      @JsonKey(name: 'close') @DateTimeConverter() required this.close,
      @JsonKey(name: 'imageID') required final List<int> imageID,
      @JsonKey(name: 'modelID') required final List<int> modelID,
      @JsonKey(name: 'detectType') required final List<int> detectType})
      : _imageID = imageID,
        _modelID = modelID,
        _detectType = detectType,
        super._();

  factory _$EventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventImplFromJson(json);

  @override
  @JsonKey(name: 'hostID')
  final int hostID;
  @override
  @JsonKey(name: 'bannerURL')
  final String bannerURL;
  @override
  @JsonKey(name: 'mapURL')
  final String mapURL;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'catchCopy')
  final String catchCopy;
  @override
  @JsonKey(name: 'description')
  final String description;
  @override
  @JsonKey(name: 'location')
  final String location;
  @override
  @JsonKey(name: 'createdAt')
  @DateTimeConverter()
  final DateTime createdAt;
  @override
  @JsonKey(name: 'open')
  @DateTimeConverter()
  final DateTime open;
  @override
  @JsonKey(name: 'close')
  @DateTimeConverter()
  final DateTime close;
  final List<int> _imageID;
  @override
  @JsonKey(name: 'imageID')
  List<int> get imageID {
    if (_imageID is EqualUnmodifiableListView) return _imageID;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageID);
  }

  final List<int> _modelID;
  @override
  @JsonKey(name: 'modelID')
  List<int> get modelID {
    if (_modelID is EqualUnmodifiableListView) return _modelID;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modelID);
  }

  final List<int> _detectType;
  @override
  @JsonKey(name: 'detectType')
  List<int> get detectType {
    if (_detectType is EqualUnmodifiableListView) return _detectType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_detectType);
  }

  @override
  String toString() {
    return 'Event(hostID: $hostID, bannerURL: $bannerURL, mapURL: $mapURL, title: $title, catchCopy: $catchCopy, description: $description, location: $location, createdAt: $createdAt, open: $open, close: $close, imageID: $imageID, modelID: $modelID, detectType: $detectType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventImpl &&
            (identical(other.hostID, hostID) || other.hostID == hostID) &&
            (identical(other.bannerURL, bannerURL) ||
                other.bannerURL == bannerURL) &&
            (identical(other.mapURL, mapURL) || other.mapURL == mapURL) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.catchCopy, catchCopy) ||
                other.catchCopy == catchCopy) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.open, open) || other.open == open) &&
            (identical(other.close, close) || other.close == close) &&
            const DeepCollectionEquality().equals(other._imageID, _imageID) &&
            const DeepCollectionEquality().equals(other._modelID, _modelID) &&
            const DeepCollectionEquality()
                .equals(other._detectType, _detectType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      hostID,
      bannerURL,
      mapURL,
      title,
      catchCopy,
      description,
      location,
      createdAt,
      open,
      close,
      const DeepCollectionEquality().hash(_imageID),
      const DeepCollectionEquality().hash(_modelID),
      const DeepCollectionEquality().hash(_detectType));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      __$$EventImplCopyWithImpl<_$EventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventImplToJson(
      this,
    );
  }
}

abstract class _Event extends Event {
  const factory _Event(
      {@JsonKey(name: 'hostID') required final int hostID,
      @JsonKey(name: 'bannerURL') required final String bannerURL,
      @JsonKey(name: 'mapURL') required final String mapURL,
      @JsonKey(name: 'title') required final String title,
      @JsonKey(name: 'catchCopy') required final String catchCopy,
      @JsonKey(name: 'description') required final String description,
      @JsonKey(name: 'location') required final String location,
      @JsonKey(name: 'createdAt')
      @DateTimeConverter()
      required final DateTime createdAt,
      @JsonKey(name: 'open') @DateTimeConverter() required final DateTime open,
      @JsonKey(name: 'close')
      @DateTimeConverter()
      required final DateTime close,
      @JsonKey(name: 'imageID') required final List<int> imageID,
      @JsonKey(name: 'modelID') required final List<int> modelID,
      @JsonKey(name: 'detectType')
      required final List<int> detectType}) = _$EventImpl;
  const _Event._() : super._();

  factory _Event.fromJson(Map<String, dynamic> json) = _$EventImpl.fromJson;

  @override
  @JsonKey(name: 'hostID')
  int get hostID;
  @override
  @JsonKey(name: 'bannerURL')
  String get bannerURL;
  @override
  @JsonKey(name: 'mapURL')
  String get mapURL;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'catchCopy')
  String get catchCopy;
  @override
  @JsonKey(name: 'description')
  String get description;
  @override
  @JsonKey(name: 'location')
  String get location;
  @override
  @JsonKey(name: 'createdAt')
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  @JsonKey(name: 'open')
  @DateTimeConverter()
  DateTime get open;
  @override
  @JsonKey(name: 'close')
  @DateTimeConverter()
  DateTime get close;
  @override
  @JsonKey(name: 'imageID')
  List<int> get imageID;
  @override
  @JsonKey(name: 'modelID')
  List<int> get modelID;
  @override
  @JsonKey(name: 'detectType')
  List<int> get detectType;
  @override
  @JsonKey(ignore: true)
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
