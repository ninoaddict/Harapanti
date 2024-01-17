// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'panti_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Panti {
  String get pantiName => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PantiCopyWith<Panti> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PantiCopyWith<$Res> {
  factory $PantiCopyWith(Panti value, $Res Function(Panti) then) =
      _$PantiCopyWithImpl<$Res, Panti>;
  @useResult
  $Res call({String pantiName, String city, String description});
}

/// @nodoc
class _$PantiCopyWithImpl<$Res, $Val extends Panti>
    implements $PantiCopyWith<$Res> {
  _$PantiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pantiName = null,
    Object? city = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      pantiName: null == pantiName
          ? _value.pantiName
          : pantiName // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PantiImplCopyWith<$Res> implements $PantiCopyWith<$Res> {
  factory _$$PantiImplCopyWith(
          _$PantiImpl value, $Res Function(_$PantiImpl) then) =
      __$$PantiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String pantiName, String city, String description});
}

/// @nodoc
class __$$PantiImplCopyWithImpl<$Res>
    extends _$PantiCopyWithImpl<$Res, _$PantiImpl>
    implements _$$PantiImplCopyWith<$Res> {
  __$$PantiImplCopyWithImpl(
      _$PantiImpl _value, $Res Function(_$PantiImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pantiName = null,
    Object? city = null,
    Object? description = null,
  }) {
    return _then(_$PantiImpl(
      pantiName: null == pantiName
          ? _value.pantiName
          : pantiName // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PantiImpl implements _Panti {
  _$PantiImpl(
      {required this.pantiName, required this.city, required this.description});

  @override
  final String pantiName;
  @override
  final String city;
  @override
  final String description;

  @override
  String toString() {
    return 'Panti(pantiName: $pantiName, city: $city, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PantiImpl &&
            (identical(other.pantiName, pantiName) ||
                other.pantiName == pantiName) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pantiName, city, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PantiImplCopyWith<_$PantiImpl> get copyWith =>
      __$$PantiImplCopyWithImpl<_$PantiImpl>(this, _$identity);
}

abstract class _Panti implements Panti {
  factory _Panti(
      {required final String pantiName,
      required final String city,
      required final String description}) = _$PantiImpl;

  @override
  String get pantiName;
  @override
  String get city;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$PantiImplCopyWith<_$PantiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
