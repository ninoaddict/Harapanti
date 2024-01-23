import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harapanti/models/application_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'application_provider.g.dart';

@riverpod
Future<List<Application>> applicationData(
    ApplicationDataRef ref, String vacancyID) async {
  final response = await FirebaseFirestore.instance
      .collection('application')
      .where('vacancyID', isEqualTo: vacancyID)
      .orderBy('createdAt', descending: true)
      .get();
  final List<Application> result = response.docs
      .map((ss) => Application(
          applicantID: ss.data()['applicantID'],
          createdAt: ss.data()['createdAt'].toDate(),
          email: ss.data()['email'],
          homeAddress: ss.data()['homeAddress'],
          imageUrl: ss.data()['imageUrl'],
          name: ss.data()['name'],
          pantiID: ss.data()['pantiID'],
          pdfUrl: ss.data()['pdfUrl'],
          vacancyID: vacancyID))
      .toList();
  return result;
}
