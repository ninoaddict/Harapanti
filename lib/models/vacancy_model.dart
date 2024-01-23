import 'package:freezed_annotation/freezed_annotation.dart';
part 'vacancy_model.freezed.dart';

@freezed
class Vacancy with _$Vacancy {
  factory Vacancy(
      {required String city,
      required DateTime createdAt,
      required DateTime endDate,
      required String imageUrl,
      required String jobType,
      required int numberOfApplicant,
      required String pantiID,
      required String pantiName,
      required String rangeType,
      required String status,
      required String syarat,
      required String tanggungjawab,
      required String vacancyID}) = _Vacancy;
}
