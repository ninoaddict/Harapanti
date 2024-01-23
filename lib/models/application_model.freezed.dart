// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Application {
  String get applicantID => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get homeAddress => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get pantiID => throw _privateConstructorUsedError;
  String get pdfUrl => throw _privateConstructorUsedError;
  String get vacancyID => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ApplicationCopyWith<Application> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicationCopyWith<$Res> {
  factory $ApplicationCopyWith(
          Application value, $Res Function(Application) then) =
      _$ApplicationCopyWithImpl<$Res, Application>;
  @useResult
  $Res call(
      {String applicantID,
      DateTime createdAt,
      String email,
      String homeAddress,
      String? imageUrl,
      String name,
      String pantiID,
      String pdfUrl,
      String vacancyID});
}

/// @nodoc
class _$ApplicationCopyWithImpl<$Res, $Val extends Application>
    implements $ApplicationCopyWith<$Res> {
  _$ApplicationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicantID = null,
    Object? createdAt = null,
    Object? email = null,
    Object? homeAddress = null,
    Object? imageUrl = freezed,
    Object? name = null,
    Object? pantiID = null,
    Object? pdfUrl = null,
    Object? vacancyID = null,
  }) {
    return _then(_value.copyWith(
      applicantID: null == applicantID
          ? _value.applicantID
          : applicantID // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      homeAddress: null == homeAddress
          ? _value.homeAddress
          : homeAddress // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pantiID: null == pantiID
          ? _value.pantiID
          : pantiID // ignore: cast_nullable_to_non_nullable
              as String,
      pdfUrl: null == pdfUrl
          ? _value.pdfUrl
          : pdfUrl // ignore: cast_nullable_to_non_nullable
              as String,
      vacancyID: null == vacancyID
          ? _value.vacancyID
          : vacancyID // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApplicationImplCopyWith<$Res>
    implements $ApplicationCopyWith<$Res> {
  factory _$$ApplicationImplCopyWith(
          _$ApplicationImpl value, $Res Function(_$ApplicationImpl) then) =
      __$$ApplicationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String applicantID,
      DateTime createdAt,
      String email,
      String homeAddress,
      String? imageUrl,
      String name,
      String pantiID,
      String pdfUrl,
      String vacancyID});
}

/// @nodoc
class __$$ApplicationImplCopyWithImpl<$Res>
    extends _$ApplicationCopyWithImpl<$Res, _$ApplicationImpl>
    implements _$$ApplicationImplCopyWith<$Res> {
  __$$ApplicationImplCopyWithImpl(
      _$ApplicationImpl _value, $Res Function(_$ApplicationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicantID = null,
    Object? createdAt = null,
    Object? email = null,
    Object? homeAddress = null,
    Object? imageUrl = freezed,
    Object? name = null,
    Object? pantiID = null,
    Object? pdfUrl = null,
    Object? vacancyID = null,
  }) {
    return _then(_$ApplicationImpl(
      applicantID: null == applicantID
          ? _value.applicantID
          : applicantID // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      homeAddress: null == homeAddress
          ? _value.homeAddress
          : homeAddress // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pantiID: null == pantiID
          ? _value.pantiID
          : pantiID // ignore: cast_nullable_to_non_nullable
              as String,
      pdfUrl: null == pdfUrl
          ? _value.pdfUrl
          : pdfUrl // ignore: cast_nullable_to_non_nullable
              as String,
      vacancyID: null == vacancyID
          ? _value.vacancyID
          : vacancyID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ApplicationImpl implements _Application {
  _$ApplicationImpl(
      {required this.applicantID,
      required this.createdAt,
      required this.email,
      required this.homeAddress,
      required this.imageUrl,
      required this.name,
      required this.pantiID,
      required this.pdfUrl,
      required this.vacancyID});

  @override
  final String applicantID;
  @override
  final DateTime createdAt;
  @override
  final String email;
  @override
  final String homeAddress;
  @override
  final String? imageUrl;
  @override
  final String name;
  @override
  final String pantiID;
  @override
  final String pdfUrl;
  @override
  final String vacancyID;

  @override
  String toString() {
    return 'Application(applicantID: $applicantID, createdAt: $createdAt, email: $email, homeAddress: $homeAddress, imageUrl: $imageUrl, name: $name, pantiID: $pantiID, pdfUrl: $pdfUrl, vacancyID: $vacancyID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplicationImpl &&
            (identical(other.applicantID, applicantID) ||
                other.applicantID == applicantID) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.homeAddress, homeAddress) ||
                other.homeAddress == homeAddress) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pantiID, pantiID) || other.pantiID == pantiID) &&
            (identical(other.pdfUrl, pdfUrl) || other.pdfUrl == pdfUrl) &&
            (identical(other.vacancyID, vacancyID) ||
                other.vacancyID == vacancyID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, applicantID, createdAt, email,
      homeAddress, imageUrl, name, pantiID, pdfUrl, vacancyID);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplicationImplCopyWith<_$ApplicationImpl> get copyWith =>
      __$$ApplicationImplCopyWithImpl<_$ApplicationImpl>(this, _$identity);
}

abstract class _Application implements Application {
  factory _Application(
      {required final String applicantID,
      required final DateTime createdAt,
      required final String email,
      required final String homeAddress,
      required final String? imageUrl,
      required final String name,
      required final String pantiID,
      required final String pdfUrl,
      required final String vacancyID}) = _$ApplicationImpl;

  @override
  String get applicantID;
  @override
  DateTime get createdAt;
  @override
  String get email;
  @override
  String get homeAddress;
  @override
  String? get imageUrl;
  @override
  String get name;
  @override
  String get pantiID;
  @override
  String get pdfUrl;
  @override
  String get vacancyID;
  @override
  @JsonKey(ignore: true)
  _$$ApplicationImplCopyWith<_$ApplicationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
