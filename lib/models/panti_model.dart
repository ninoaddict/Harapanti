import 'package:freezed_annotation/freezed_annotation.dart';
part 'panti_model.freezed.dart';

@freezed
class Panti with _$Panti {
  factory Panti(
      {required String pantiName,
      required String city,
      required String description,
      required int numberOfAttendant,
      required int numberOfResident,
      required String phoneNumber,
      required String biography,
      required String address,
      required String pengelola,
      required int est,
      required String? imageUrl,
      required List<dynamic> imageList,
      required String pantiID}) = _Panti;
}
