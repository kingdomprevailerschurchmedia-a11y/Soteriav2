// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestionDto {

 String get id; String get text; String? get explanation; String get difficulty; String get categoryId; String? get subcategoryId; String? get topicId; String get type; List<AnswerDto> get options; List<String> get correctOptionIds; List<String> get tags; String get language; int get estimatedTimeSeconds; int get xpValue; int get coinValue; String get status; String get version; String get createdAt; String get updatedAt; String? get author; String get source; int get schemaVersion; String? get contentHash; Map<String, dynamic> get metadata;
/// Create a copy of QuestionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionDtoCopyWith<QuestionDto> get copyWith => _$QuestionDtoCopyWithImpl<QuestionDto>(this as QuestionDto, _$identity);

  /// Serializes this QuestionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.subcategoryId, subcategoryId) || other.subcategoryId == subcategoryId)&&(identical(other.topicId, topicId) || other.topicId == topicId)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.options, options)&&const DeepCollectionEquality().equals(other.correctOptionIds, correctOptionIds)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.language, language) || other.language == language)&&(identical(other.estimatedTimeSeconds, estimatedTimeSeconds) || other.estimatedTimeSeconds == estimatedTimeSeconds)&&(identical(other.xpValue, xpValue) || other.xpValue == xpValue)&&(identical(other.coinValue, coinValue) || other.coinValue == coinValue)&&(identical(other.status, status) || other.status == status)&&(identical(other.version, version) || other.version == version)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.author, author) || other.author == author)&&(identical(other.source, source) || other.source == source)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.contentHash, contentHash) || other.contentHash == contentHash)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,text,explanation,difficulty,categoryId,subcategoryId,topicId,type,const DeepCollectionEquality().hash(options),const DeepCollectionEquality().hash(correctOptionIds),const DeepCollectionEquality().hash(tags),language,estimatedTimeSeconds,xpValue,coinValue,status,version,createdAt,updatedAt,author,source,schemaVersion,contentHash,const DeepCollectionEquality().hash(metadata)]);

@override
String toString() {
  return 'QuestionDto(id: $id, text: $text, explanation: $explanation, difficulty: $difficulty, categoryId: $categoryId, subcategoryId: $subcategoryId, topicId: $topicId, type: $type, options: $options, correctOptionIds: $correctOptionIds, tags: $tags, language: $language, estimatedTimeSeconds: $estimatedTimeSeconds, xpValue: $xpValue, coinValue: $coinValue, status: $status, version: $version, createdAt: $createdAt, updatedAt: $updatedAt, author: $author, source: $source, schemaVersion: $schemaVersion, contentHash: $contentHash, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $QuestionDtoCopyWith<$Res>  {
  factory $QuestionDtoCopyWith(QuestionDto value, $Res Function(QuestionDto) _then) = _$QuestionDtoCopyWithImpl;
@useResult
$Res call({
 String id, String text, String? explanation, String difficulty, String categoryId, String? subcategoryId, String? topicId, String type, List<AnswerDto> options, List<String> correctOptionIds, List<String> tags, String language, int estimatedTimeSeconds, int xpValue, int coinValue, String status, String version, String createdAt, String updatedAt, String? author, String source, int schemaVersion, String? contentHash, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$QuestionDtoCopyWithImpl<$Res>
    implements $QuestionDtoCopyWith<$Res> {
  _$QuestionDtoCopyWithImpl(this._self, this._then);

  final QuestionDto _self;
  final $Res Function(QuestionDto) _then;

/// Create a copy of QuestionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? explanation = freezed,Object? difficulty = null,Object? categoryId = null,Object? subcategoryId = freezed,Object? topicId = freezed,Object? type = null,Object? options = null,Object? correctOptionIds = null,Object? tags = null,Object? language = null,Object? estimatedTimeSeconds = null,Object? xpValue = null,Object? coinValue = null,Object? status = null,Object? version = null,Object? createdAt = null,Object? updatedAt = null,Object? author = freezed,Object? source = null,Object? schemaVersion = null,Object? contentHash = freezed,Object? metadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,subcategoryId: freezed == subcategoryId ? _self.subcategoryId : subcategoryId // ignore: cast_nullable_to_non_nullable
as String?,topicId: freezed == topicId ? _self.topicId : topicId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<AnswerDto>,correctOptionIds: null == correctOptionIds ? _self.correctOptionIds : correctOptionIds // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,estimatedTimeSeconds: null == estimatedTimeSeconds ? _self.estimatedTimeSeconds : estimatedTimeSeconds // ignore: cast_nullable_to_non_nullable
as int,xpValue: null == xpValue ? _self.xpValue : xpValue // ignore: cast_nullable_to_non_nullable
as int,coinValue: null == coinValue ? _self.coinValue : coinValue // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,contentHash: freezed == contentHash ? _self.contentHash : contentHash // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionDto].
extension QuestionDtoPatterns on QuestionDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionDto value)  $default,){
final _that = this;
switch (_that) {
case _QuestionDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionDto value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  String? explanation,  String difficulty,  String categoryId,  String? subcategoryId,  String? topicId,  String type,  List<AnswerDto> options,  List<String> correctOptionIds,  List<String> tags,  String language,  int estimatedTimeSeconds,  int xpValue,  int coinValue,  String status,  String version,  String createdAt,  String updatedAt,  String? author,  String source,  int schemaVersion,  String? contentHash,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionDto() when $default != null:
return $default(_that.id,_that.text,_that.explanation,_that.difficulty,_that.categoryId,_that.subcategoryId,_that.topicId,_that.type,_that.options,_that.correctOptionIds,_that.tags,_that.language,_that.estimatedTimeSeconds,_that.xpValue,_that.coinValue,_that.status,_that.version,_that.createdAt,_that.updatedAt,_that.author,_that.source,_that.schemaVersion,_that.contentHash,_that.metadata);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  String? explanation,  String difficulty,  String categoryId,  String? subcategoryId,  String? topicId,  String type,  List<AnswerDto> options,  List<String> correctOptionIds,  List<String> tags,  String language,  int estimatedTimeSeconds,  int xpValue,  int coinValue,  String status,  String version,  String createdAt,  String updatedAt,  String? author,  String source,  int schemaVersion,  String? contentHash,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _QuestionDto():
return $default(_that.id,_that.text,_that.explanation,_that.difficulty,_that.categoryId,_that.subcategoryId,_that.topicId,_that.type,_that.options,_that.correctOptionIds,_that.tags,_that.language,_that.estimatedTimeSeconds,_that.xpValue,_that.coinValue,_that.status,_that.version,_that.createdAt,_that.updatedAt,_that.author,_that.source,_that.schemaVersion,_that.contentHash,_that.metadata);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  String? explanation,  String difficulty,  String categoryId,  String? subcategoryId,  String? topicId,  String type,  List<AnswerDto> options,  List<String> correctOptionIds,  List<String> tags,  String language,  int estimatedTimeSeconds,  int xpValue,  int coinValue,  String status,  String version,  String createdAt,  String updatedAt,  String? author,  String source,  int schemaVersion,  String? contentHash,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _QuestionDto() when $default != null:
return $default(_that.id,_that.text,_that.explanation,_that.difficulty,_that.categoryId,_that.subcategoryId,_that.topicId,_that.type,_that.options,_that.correctOptionIds,_that.tags,_that.language,_that.estimatedTimeSeconds,_that.xpValue,_that.coinValue,_that.status,_that.version,_that.createdAt,_that.updatedAt,_that.author,_that.source,_that.schemaVersion,_that.contentHash,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestionDto implements QuestionDto {
  const _QuestionDto({required this.id, required this.text, this.explanation, required this.difficulty, required this.categoryId, this.subcategoryId, this.topicId, required this.type, required final  List<AnswerDto> options, required final  List<String> correctOptionIds, final  List<String> tags = const [], this.language = 'en', this.estimatedTimeSeconds = 30, this.xpValue = 10, this.coinValue = 5, this.status = 'draft', this.version = '1.0.0', required this.createdAt, required this.updatedAt, this.author, required this.source, this.schemaVersion = 1, this.contentHash, final  Map<String, dynamic> metadata = const {}}): _options = options,_correctOptionIds = correctOptionIds,_tags = tags,_metadata = metadata;
  factory _QuestionDto.fromJson(Map<String, dynamic> json) => _$QuestionDtoFromJson(json);

@override final  String id;
@override final  String text;
@override final  String? explanation;
@override final  String difficulty;
@override final  String categoryId;
@override final  String? subcategoryId;
@override final  String? topicId;
@override final  String type;
 final  List<AnswerDto> _options;
@override List<AnswerDto> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

 final  List<String> _correctOptionIds;
@override List<String> get correctOptionIds {
  if (_correctOptionIds is EqualUnmodifiableListView) return _correctOptionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_correctOptionIds);
}

 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  String language;
@override@JsonKey() final  int estimatedTimeSeconds;
@override@JsonKey() final  int xpValue;
@override@JsonKey() final  int coinValue;
@override@JsonKey() final  String status;
@override@JsonKey() final  String version;
@override final  String createdAt;
@override final  String updatedAt;
@override final  String? author;
@override final  String source;
@override@JsonKey() final  int schemaVersion;
@override final  String? contentHash;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of QuestionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionDtoCopyWith<_QuestionDto> get copyWith => __$QuestionDtoCopyWithImpl<_QuestionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.subcategoryId, subcategoryId) || other.subcategoryId == subcategoryId)&&(identical(other.topicId, topicId) || other.topicId == topicId)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._options, _options)&&const DeepCollectionEquality().equals(other._correctOptionIds, _correctOptionIds)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.language, language) || other.language == language)&&(identical(other.estimatedTimeSeconds, estimatedTimeSeconds) || other.estimatedTimeSeconds == estimatedTimeSeconds)&&(identical(other.xpValue, xpValue) || other.xpValue == xpValue)&&(identical(other.coinValue, coinValue) || other.coinValue == coinValue)&&(identical(other.status, status) || other.status == status)&&(identical(other.version, version) || other.version == version)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.author, author) || other.author == author)&&(identical(other.source, source) || other.source == source)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.contentHash, contentHash) || other.contentHash == contentHash)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,text,explanation,difficulty,categoryId,subcategoryId,topicId,type,const DeepCollectionEquality().hash(_options),const DeepCollectionEquality().hash(_correctOptionIds),const DeepCollectionEquality().hash(_tags),language,estimatedTimeSeconds,xpValue,coinValue,status,version,createdAt,updatedAt,author,source,schemaVersion,contentHash,const DeepCollectionEquality().hash(_metadata)]);

@override
String toString() {
  return 'QuestionDto(id: $id, text: $text, explanation: $explanation, difficulty: $difficulty, categoryId: $categoryId, subcategoryId: $subcategoryId, topicId: $topicId, type: $type, options: $options, correctOptionIds: $correctOptionIds, tags: $tags, language: $language, estimatedTimeSeconds: $estimatedTimeSeconds, xpValue: $xpValue, coinValue: $coinValue, status: $status, version: $version, createdAt: $createdAt, updatedAt: $updatedAt, author: $author, source: $source, schemaVersion: $schemaVersion, contentHash: $contentHash, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$QuestionDtoCopyWith<$Res> implements $QuestionDtoCopyWith<$Res> {
  factory _$QuestionDtoCopyWith(_QuestionDto value, $Res Function(_QuestionDto) _then) = __$QuestionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, String? explanation, String difficulty, String categoryId, String? subcategoryId, String? topicId, String type, List<AnswerDto> options, List<String> correctOptionIds, List<String> tags, String language, int estimatedTimeSeconds, int xpValue, int coinValue, String status, String version, String createdAt, String updatedAt, String? author, String source, int schemaVersion, String? contentHash, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$QuestionDtoCopyWithImpl<$Res>
    implements _$QuestionDtoCopyWith<$Res> {
  __$QuestionDtoCopyWithImpl(this._self, this._then);

  final _QuestionDto _self;
  final $Res Function(_QuestionDto) _then;

/// Create a copy of QuestionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? explanation = freezed,Object? difficulty = null,Object? categoryId = null,Object? subcategoryId = freezed,Object? topicId = freezed,Object? type = null,Object? options = null,Object? correctOptionIds = null,Object? tags = null,Object? language = null,Object? estimatedTimeSeconds = null,Object? xpValue = null,Object? coinValue = null,Object? status = null,Object? version = null,Object? createdAt = null,Object? updatedAt = null,Object? author = freezed,Object? source = null,Object? schemaVersion = null,Object? contentHash = freezed,Object? metadata = null,}) {
  return _then(_QuestionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,subcategoryId: freezed == subcategoryId ? _self.subcategoryId : subcategoryId // ignore: cast_nullable_to_non_nullable
as String?,topicId: freezed == topicId ? _self.topicId : topicId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<AnswerDto>,correctOptionIds: null == correctOptionIds ? _self._correctOptionIds : correctOptionIds // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,estimatedTimeSeconds: null == estimatedTimeSeconds ? _self.estimatedTimeSeconds : estimatedTimeSeconds // ignore: cast_nullable_to_non_nullable
as int,xpValue: null == xpValue ? _self.xpValue : xpValue // ignore: cast_nullable_to_non_nullable
as int,coinValue: null == coinValue ? _self.coinValue : coinValue // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,contentHash: freezed == contentHash ? _self.contentHash : contentHash // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$AnswerDto {

 String get id; String get text; String? get mediaUrl; int get displayOrder;
/// Create a copy of AnswerDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnswerDtoCopyWith<AnswerDto> get copyWith => _$AnswerDtoCopyWithImpl<AnswerDto>(this as AnswerDto, _$identity);

  /// Serializes this AnswerDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnswerDto&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,mediaUrl,displayOrder);

@override
String toString() {
  return 'AnswerDto(id: $id, text: $text, mediaUrl: $mediaUrl, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class $AnswerDtoCopyWith<$Res>  {
  factory $AnswerDtoCopyWith(AnswerDto value, $Res Function(AnswerDto) _then) = _$AnswerDtoCopyWithImpl;
@useResult
$Res call({
 String id, String text, String? mediaUrl, int displayOrder
});




}
/// @nodoc
class _$AnswerDtoCopyWithImpl<$Res>
    implements $AnswerDtoCopyWith<$Res> {
  _$AnswerDtoCopyWithImpl(this._self, this._then);

  final AnswerDto _self;
  final $Res Function(AnswerDto) _then;

/// Create a copy of AnswerDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? mediaUrl = freezed,Object? displayOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AnswerDto].
extension AnswerDtoPatterns on AnswerDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnswerDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnswerDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnswerDto value)  $default,){
final _that = this;
switch (_that) {
case _AnswerDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnswerDto value)?  $default,){
final _that = this;
switch (_that) {
case _AnswerDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  String? mediaUrl,  int displayOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnswerDto() when $default != null:
return $default(_that.id,_that.text,_that.mediaUrl,_that.displayOrder);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  String? mediaUrl,  int displayOrder)  $default,) {final _that = this;
switch (_that) {
case _AnswerDto():
return $default(_that.id,_that.text,_that.mediaUrl,_that.displayOrder);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  String? mediaUrl,  int displayOrder)?  $default,) {final _that = this;
switch (_that) {
case _AnswerDto() when $default != null:
return $default(_that.id,_that.text,_that.mediaUrl,_that.displayOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnswerDto implements AnswerDto {
  const _AnswerDto({required this.id, required this.text, this.mediaUrl, this.displayOrder = 0});
  factory _AnswerDto.fromJson(Map<String, dynamic> json) => _$AnswerDtoFromJson(json);

@override final  String id;
@override final  String text;
@override final  String? mediaUrl;
@override@JsonKey() final  int displayOrder;

/// Create a copy of AnswerDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnswerDtoCopyWith<_AnswerDto> get copyWith => __$AnswerDtoCopyWithImpl<_AnswerDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnswerDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnswerDto&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,mediaUrl,displayOrder);

@override
String toString() {
  return 'AnswerDto(id: $id, text: $text, mediaUrl: $mediaUrl, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class _$AnswerDtoCopyWith<$Res> implements $AnswerDtoCopyWith<$Res> {
  factory _$AnswerDtoCopyWith(_AnswerDto value, $Res Function(_AnswerDto) _then) = __$AnswerDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, String? mediaUrl, int displayOrder
});




}
/// @nodoc
class __$AnswerDtoCopyWithImpl<$Res>
    implements _$AnswerDtoCopyWith<$Res> {
  __$AnswerDtoCopyWithImpl(this._self, this._then);

  final _AnswerDto _self;
  final $Res Function(_AnswerDto) _then;

/// Create a copy of AnswerDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? mediaUrl = freezed,Object? displayOrder = null,}) {
  return _then(_AnswerDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
