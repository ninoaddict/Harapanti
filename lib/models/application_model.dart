import 'package:freezed_annotation/freezed_annotation.dart';
part 'application_model.freezed.dart';

@freezed
class Application with _$Application {
  factory Application({
    required String applicantID,
    required DateTime createdAt,
    required String email,
    required String homeAddress,
    required String? imageUrl,
    required String name,
    required String pantiID,
    required String pdfUrl,
    required String vacancyID,
  }) = _Application;
}
