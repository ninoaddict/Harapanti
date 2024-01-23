import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harapanti/models/vacancy_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vacancy_provider.g.dart';

@riverpod
class VacancyList extends _$VacancyList {
  @override
  Future<List<Vacancy>> build() async {
    final vacancyData = await FirebaseFirestore.instance
        .collection('vacancy')
        .orderBy('createdAt', descending: true)
        .get();
    final List<Vacancy> response = vacancyData.docs
        .map(
          (data) => Vacancy(
              city: data['city'],
              createdAt: data['createdAt'].toDate(),
              endDate: data['endDate'].toDate(),
              imageUrl: data['imageUrl'],
              jobType: data['jobType'],
              numberOfApplicant: data['numberOfApplicant'],
              pantiName: data['pantiName'],
              rangeType: data['rangeType'],
              status: data['status'],
              syarat: data['syarat'],
              tanggungjawab: data['tanggungjawab'],
              vacancyID: data.id,
              pantiID: data['pantiID']),
        )
        .toList();
    return response;
  }

  Future<void> createVacancy(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection('vacancy').add(data);

    ref.invalidateSelf();

    await future;
  }
}

@riverpod
Future<List<Vacancy>> listVacancyByFilter(
  ListVacancyByFilterRef ref,
  List<String> listJobType,
  List<String> listRangeType,
) async {
  final vacancyData = await FirebaseFirestore.instance
      .collection('vacancy')
      .orderBy('createdAt', descending: true)
      .where(Filter.and(Filter('jobType', whereIn: listJobType),
          Filter('rangeType', whereIn: listRangeType)))
      .get();

  final List<Vacancy> response = vacancyData.docs
      .map(
        (data) => Vacancy(
            city: data['city'],
            createdAt: data['createdAt'].toDate(),
            endDate: data['endDate'].toDate(),
            imageUrl: data['imageUrl'],
            jobType: data['jobType'],
            numberOfApplicant: data['numberOfApplicant'],
            pantiName: data['pantiName'],
            rangeType: data['rangeType'],
            status: data['status'],
            syarat: data['syarat'],
            tanggungjawab: data['tanggungjawab'],
            vacancyID: data.id,
            pantiID: data['pantiID']),
      )
      .toList();
  return response;
}

@riverpod
Future<List<Vacancy>> listVacancyByPanti(
    ListVacancyByPantiRef ref, String status, String pantiID) async {
  if (status == 'all') {
    final response = await FirebaseFirestore.instance
        .collection('vacancy')
        .orderBy('createdAt', descending: true)
        .where('pantiID', isEqualTo: pantiID)
        .get();
    final List<Vacancy> result = response.docs
        .map((ss) => Vacancy(
            city: ss.data()['city'],
            createdAt: ss.data()['createdAt'].toDate(),
            endDate: ss.data()['endDate'].toDate(),
            imageUrl: ss.data()['imageUrl'],
            jobType: ss.data()['jobType'],
            numberOfApplicant: ss.data()['numberOfApplicant'],
            pantiID: pantiID,
            pantiName: ss.data()['pantiName'],
            rangeType: ss.data()['rangeType'],
            status: status,
            syarat: ss.data()['syarat'],
            tanggungjawab: ss.data()['tanggungjawab'],
            vacancyID: ss.id))
        .toList();
    return result;
  } else {
    final response = await FirebaseFirestore.instance
        .collection('vacancy')
        .orderBy('createdAt', descending: true)
        .where('pantiID', isEqualTo: pantiID)
        .where('status', isEqualTo: status)
        .get();
    final List<Vacancy> result = response.docs
        .map((ss) => Vacancy(
            city: ss.data()['city'],
            createdAt: ss.data()['createdAt'].toDate(),
            endDate: ss.data()['endDate'].toDate(),
            imageUrl: ss.data()['imageUrl'],
            jobType: ss.data()['jobType'],
            numberOfApplicant: ss.data()['numberOfApplicant'],
            pantiID: pantiID,
            pantiName: ss.data()['pantiName'],
            rangeType: ss.data()['rangeType'],
            status: status,
            syarat: ss.data()['syarat'],
            tanggungjawab: ss.data()['tanggungjawab'],
            vacancyID: ss.id))
        .toList();
    return result;
  }
}
