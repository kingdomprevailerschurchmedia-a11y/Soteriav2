// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Question {

 String get id; String get text; String? get explanation; Difficulty get difficulty; String get categoryId; String? get subcategoryId; String? get topicId; QuestionType get type; List<Answer> get options;/// Authoritative correct answer IDs. 
/// CRITICAL: This must be stripped in client-facing competitive payloads.
 List<String> get correctOptionIds; List<String> get tags; String get language;@DurationConverter() Duration get estimatedTime; int get xpValue; int get coinValue; QuestionStatus get status; String get version; DateTime get createdAt; DateTime get updatedAt; String? get author; String get source; int get schemaVersion; String? get contentHash; Map<String, dynamic> get metadata;
/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionCopyWith<Question> get copyWith => _$QuestionCopyWithImpl<Question>(this as Question, _$identity);

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Question&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.subcategoryId, subcategoryId) || other.subcategoryId == subcategoryId)&&(identical(other.topicId, topicId) || other.topicId == topicId)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.options, options)&&const DeepCollectionEquality().equals(other.correctOptionIds, correctOptionIds)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.language, language) || other.language == language)&&(identical(other.estimatedTime, estimatedTime) || other.estimatedTime == estimatedTime)&&(identical(other.xpValue, xpValue) || other.xpValue == xpValue)&&(identical(other.coinValue, coinValue) || other.coinValue == coinValue)&&(identical(other.status, status) || other.status == status)&&(identical(other.version, version) || other.version == version)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.author, author) || other.author == author)&&(identical(other.source, source) || other.source == source)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.contentHash, contentHash) || other.contentHash == contentHash)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,text,explanation,difficulty,categoryId,subcategoryId,topicId,type,const DeepCollectionEquality().hash(options),const DeepCollectionEquality().hash(correctOptionIds),const DeepCollectionEquality().hash(tags),language,estimatedTime,xpValue,coinValue,status,version,createdAt,updatedAt,author,source,schemaVersion,contentHash,const DeepCollectionEquality().hash(metadata)]);

@override
String toString() {
  return 'Question(id: $id, text: $text, explanation: $explanation, difficulty: $difficulty, categoryId: $categoryId, subcategoryId: $subcategoryId, topicId: $topicId, type: $type, options: $options, correctOptionIds: $correctOptionIds, tags: $tags, language: $language, estimatedTime: $estimatedTime, xpValue: $xpValue, coinValue: $coinValue, status: $status, version: $version, createdAt: $createdAt, updatedAt: $updatedAt, author: $author, source: $source, schemaVersion: $schemaVersion, contentHash: $contentHash, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $QuestionCopyWith<$Res>  {
  factory $QuestionCopyWith(Question value, $Res Function(Question) _then) = _$QuestionCopyWithImpl;
@useResult
$Res call({
 String id, String text, String? explanation, Difficulty difficulty, String categoryId, String? subcategoryId, String? topicId, QuestionType type, List<Answer> options, List<String> correctOptionIds, List<String> tags, String language,@DurationConverter() Duration estimatedTime, int xpValue, int coinValue, QuestionStatus status, String version, DateTime createdAt, DateTime updatedAt, String? author, String source, int schemaVersion, String? contentHash, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$QuestionCopyWithImpl<$Res>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._self, this._then);

  final Question _self;
  final $Res Function(Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? explanation = freezed,Object? difficulty = null,Object? categoryId = null,Object? subcategoryId = freezed,Object? topicId = freezed,Object? type = null,Object? options = null,Object? correctOptionIds = null,Object? tags = null,Object? language = null,Object? estimatedTime = null,Object? xpValue = null,Object? coinValue = null,Object? status = null,Object? version = null,Object? createdAt = null,Object? updatedAt = null,Object? author = freezed,Object? source = null,Object? schemaVersion = null,Object? contentHash = freezed,Object? metadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,subcategoryId: freezed == subcategoryId ? _self.subcategoryId : subcategoryId // ignore: cast_nullable_to_non_nullable
as String?,topicId: freezed == topicId ? _self.topicId : topicId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<Answer>,correctOptionIds: null == correctOptionIds ? _self.correctOptionIds : correctOptionIds // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,estimatedTime: null == estimatedTime ? _self.estimatedTime : estimatedTime // ignore: cast_nullable_to_non_nullable
as Duration,xpValue: null == xpValue ? _self.xpValue : xpValue // ignore: cast_nullable_to_non_nullable
as int,coinValue: null == coinValue ? _self.coinValue : coinValue // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuestionStatus,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,contentHash: freezed == contentHash ? _self.contentHash : contentHash // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [Question].
extension QuestionPatterns on Question {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Question value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Question value)  $default,){
final _that = this;
switch (_that) {
case _Question():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Question value)?  $default,){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  String? explanation,  Difficulty difficulty,  String categoryId,  String? subcategoryId,  String? topicId,  QuestionType type,  List<Answer> options,  List<String> correctOptionIds,  List<String> tags,  String language, @DurationConverter()  Duration estimatedTime,  int xpValue,  int coinValue,  QuestionStatus status,  String version,  DateTime createdAt,  DateTime updatedAt,  String? author,  String source,  int schemaVersion,  String? contentHash,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.text,_that.explanation,_that.difficulty,_that.categoryId,_that.subcategoryId,_that.topicId,_that.type,_that.options,_that.correctOptionIds,_that.tags,_that.language,_that.estimatedTime,_that.xpValue,_that.coinValue,_that.status,_that.version,_that.createdAt,_that.updatedAt,_that.author,_that.source,_that.schemaVersion,_that.contentHash,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  String? explanation,  Difficulty difficulty,  String categoryId,  String? subcategoryId,  String? topicId,  QuestionType type,  List<Answer> options,  List<String> correctOptionIds,  List<String> tags,  String language, @DurationConverter()  Duration estimatedTime,  int xpValue,  int coinValue,  QuestionStatus status,  String version,  DateTime createdAt,  DateTime updatedAt,  String? author,  String source,  int schemaVersion,  String? contentHash,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _Question():
return $default(_that.id,_that.text,_that.explanation,_that.difficulty,_that.categoryId,_that.subcategoryId,_that.topicId,_that.type,_that.options,_that.correctOptionIds,_that.tags,_that.language,_that.estimatedTime,_that.xpValue,_that.coinValue,_that.status,_that.version,_that.createdAt,_that.updatedAt,_that.author,_that.source,_that.schemaVersion,_that.contentHash,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  String? explanation,  Difficulty difficulty,  String categoryId,  String? subcategoryId,  String? topicId,  QuestionType type,  List<Answer> options,  List<String> correctOptionIds,  List<String> tags,  String language, @DurationConverter()  Duration estimatedTime,  int xpValue,  int coinValue,  QuestionStatus status,  String version,  DateTime createdAt,  DateTime updatedAt,  String? author,  String source,  int schemaVersion,  String? contentHash,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.text,_that.explanation,_that.difficulty,_that.categoryId,_that.subcategoryId,_that.topicId,_that.type,_that.options,_that.correctOptionIds,_that.tags,_that.language,_that.estimatedTime,_that.xpValue,_that.coinValue,_that.status,_that.version,_that.createdAt,_that.updatedAt,_that.author,_that.source,_that.schemaVersion,_that.contentHash,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Question extends Question {
  const _Question({required this.id, required this.text, this.explanation, required this.difficulty, required this.categoryId, this.subcategoryId, this.topicId, required this.type, required final  List<Answer> options, required final  List<String> correctOptionIds, final  List<String> tags = const [], this.language = 'en', @DurationConverter() this.estimatedTime = const Duration(seconds: 30), this.xpValue = 10, this.coinValue = 5, this.status = QuestionStatus.draft, this.version = '1.0.0', required this.createdAt, required this.updatedAt, this.author, required this.source, this.schemaVersion = 1, this.contentHash, final  Map<String, dynamic> metadata = const {}}): _options = options,_correctOptionIds = correctOptionIds,_tags = tags,_metadata = metadata,super._();
  factory _Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

@override final  String id;
@override final  String text;
@override final  String? explanation;
@override final  Difficulty difficulty;
@override final  String categoryId;
@override final  String? subcategoryId;
@override final  String? topicId;
@override final  QuestionType type;
 final  List<Answer> _options;
@override List<Answer> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

/// Authoritative correct answer IDs. 
/// CRITICAL: This must be stripped in client-facing competitive payloads.
 final  List<String> _correctOptionIds;
/// Authoritative correct answer IDs. 
/// CRITICAL: This must be stripped in client-facing competitive payloads.
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
@override@JsonKey()@DurationConverter() final  Duration estimatedTime;
@override@JsonKey() final  int xpValue;
@override@JsonKey() final  int coinValue;
@override@JsonKey() final  QuestionStatus status;
@override@JsonKey() final  String version;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
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


/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionCopyWith<_Question> get copyWith => __$QuestionCopyWithImpl<_Question>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Question&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.subcategoryId, subcategoryId) || other.subcategoryId == subcategoryId)&&(identical(other.topicId, topicId) || other.topicId == topicId)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._options, _options)&&const DeepCollectionEquality().equals(other._correctOptionIds, _correctOptionIds)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.language, language) || other.language == language)&&(identical(other.estimatedTime, estimatedTime) || other.estimatedTime == estimatedTime)&&(identical(other.xpValue, xpValue) || other.xpValue == xpValue)&&(identical(other.coinValue, coinValue) || other.coinValue == coinValue)&&(identical(other.status, status) || other.status == status)&&(identical(other.version, version) || other.version == version)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.author, author) || other.author == author)&&(identical(other.source, source) || other.source == source)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.contentHash, contentHash) || other.contentHash == contentHash)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,text,explanation,difficulty,categoryId,subcategoryId,topicId,type,const DeepCollectionEquality().hash(_options),const DeepCollectionEquality().hash(_correctOptionIds),const DeepCollectionEquality().hash(_tags),language,estimatedTime,xpValue,coinValue,status,version,createdAt,updatedAt,author,source,schemaVersion,contentHash,const DeepCollectionEquality().hash(_metadata)]);

@override
String toString() {
  return 'Question(id: $id, text: $text, explanation: $explanation, difficulty: $difficulty, categoryId: $categoryId, subcategoryId: $subcategoryId, topicId: $topicId, type: $type, options: $options, correctOptionIds: $correctOptionIds, tags: $tags, language: $language, estimatedTime: $estimatedTime, xpValue: $xpValue, coinValue: $coinValue, status: $status, version: $version, createdAt: $createdAt, updatedAt: $updatedAt, author: $author, source: $source, schemaVersion: $schemaVersion, contentHash: $contentHash, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$QuestionCopyWith(_Question value, $Res Function(_Question) _then) = __$QuestionCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, String? explanation, Difficulty difficulty, String categoryId, String? subcategoryId, String? topicId, QuestionType type, List<Answer> options, List<String> correctOptionIds, List<String> tags, String language,@DurationConverter() Duration estimatedTime, int xpValue, int coinValue, QuestionStatus status, String version, DateTime createdAt, DateTime updatedAt, String? author, String source, int schemaVersion, String? contentHash, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$QuestionCopyWithImpl<$Res>
    implements _$QuestionCopyWith<$Res> {
  __$QuestionCopyWithImpl(this._self, this._then);

  final _Question _self;
  final $Res Function(_Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? explanation = freezed,Object? difficulty = null,Object? categoryId = null,Object? subcategoryId = freezed,Object? topicId = freezed,Object? type = null,Object? options = null,Object? correctOptionIds = null,Object? tags = null,Object? language = null,Object? estimatedTime = null,Object? xpValue = null,Object? coinValue = null,Object? status = null,Object? version = null,Object? createdAt = null,Object? updatedAt = null,Object? author = freezed,Object? source = null,Object? schemaVersion = null,Object? contentHash = freezed,Object? metadata = null,}) {
  return _then(_Question(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,subcategoryId: freezed == subcategoryId ? _self.subcategoryId : subcategoryId // ignore: cast_nullable_to_non_nullable
as String?,topicId: freezed == topicId ? _self.topicId : topicId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<Answer>,correctOptionIds: null == correctOptionIds ? _self._correctOptionIds : correctOptionIds // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,estimatedTime: null == estimatedTime ? _self.estimatedTime : estimatedTime // ignore: cast_nullable_to_non_nullable
as Duration,xpValue: null == xpValue ? _self.xpValue : xpValue // ignore: cast_nullable_to_non_nullable
as int,coinValue: null == coinValue ? _self.coinValue : coinValue // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuestionStatus,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,contentHash: freezed == contentHash ? _self.contentHash : contentHash // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$Answer {

 String get id; String get text; String? get mediaUrl; int get displayOrder;
/// Create a copy of Answer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnswerCopyWith<Answer> get copyWith => _$AnswerCopyWithImpl<Answer>(this as Answer, _$identity);

  /// Serializes this Answer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Answer&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,mediaUrl,displayOrder);

@override
String toString() {
  return 'Answer(id: $id, text: $text, mediaUrl: $mediaUrl, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class $AnswerCopyWith<$Res>  {
  factory $AnswerCopyWith(Answer value, $Res Function(Answer) _then) = _$AnswerCopyWithImpl;
@useResult
$Res call({
 String id, String text, String? mediaUrl, int displayOrder
});




}
/// @nodoc
class _$AnswerCopyWithImpl<$Res>
    implements $AnswerCopyWith<$Res> {
  _$AnswerCopyWithImpl(this._self, this._then);

  final Answer _self;
  final $Res Function(Answer) _then;

/// Create a copy of Answer
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


/// Adds pattern-matching-related methods to [Answer].
extension AnswerPatterns on Answer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Answer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Answer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Answer value)  $default,){
final _that = this;
switch (_that) {
case _Answer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Answer value)?  $default,){
final _that = this;
switch (_that) {
case _Answer() when $default != null:
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
case _Answer() when $default != null:
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
case _Answer():
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
case _Answer() when $default != null:
return $default(_that.id,_that.text,_that.mediaUrl,_that.displayOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Answer implements Answer {
  const _Answer({required this.id, required this.text, this.mediaUrl, this.displayOrder = 0});
  factory _Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

@override final  String id;
@override final  String text;
@override final  String? mediaUrl;
@override@JsonKey() final  int displayOrder;

/// Create a copy of Answer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnswerCopyWith<_Answer> get copyWith => __$AnswerCopyWithImpl<_Answer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnswerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Answer&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,mediaUrl,displayOrder);

@override
String toString() {
  return 'Answer(id: $id, text: $text, mediaUrl: $mediaUrl, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class _$AnswerCopyWith<$Res> implements $AnswerCopyWith<$Res> {
  factory _$AnswerCopyWith(_Answer value, $Res Function(_Answer) _then) = __$AnswerCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, String? mediaUrl, int displayOrder
});




}
/// @nodoc
class __$AnswerCopyWithImpl<$Res>
    implements _$AnswerCopyWith<$Res> {
  __$AnswerCopyWithImpl(this._self, this._then);

  final _Answer _self;
  final $Res Function(_Answer) _then;

/// Create a copy of Answer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? mediaUrl = freezed,Object? displayOrder = null,}) {
  return _then(_Answer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
