import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel(
      {required String category,
      required String email,
      required String? imageUrl,
      required String username}) = _UserModel;
}
