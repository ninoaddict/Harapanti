import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:harapanti/models/panti_model.dart';

part 'job_provider.g.dart';

@riverpod
Future<List<Panti>> pantiData(PantiDataRef ref, String cityQuery) async {
  if (cityQuery == '') {
    final pantiListData =
        await FirebaseFirestore.instance.collection('pantiData').get();
    final List<Panti> resultData = pantiListData.docs
        .map((ss) => Panti(
            pantiName: ss.data()['pantiName'],
            city: ss.data()['city'],
            description: ss.data()['description']))
        .toList();
    return resultData;
  } else {
    final pantiListData = await FirebaseFirestore.instance
        .collection('pantiData')
        .where('city', isEqualTo: cityQuery)
        .get();
    final List<Panti> resultData = pantiListData.docs
        .map((ss) => Panti(
            pantiName: ss.data()['pantiName'],
            city: ss.data()['city'],
            description: ss.data()['description']))
        .toList();
    return resultData;
  }
}
