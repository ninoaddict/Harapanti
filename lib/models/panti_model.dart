import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'panti_model.freezed.dart';

@freezed
class Panti with _$Panti {
  factory Panti({
    required String pantiName,
    required String city,
    required String description,
  }) = _Panti;
}
