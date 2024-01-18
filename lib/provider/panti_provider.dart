import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:harapanti/models/panti_model.dart';

part 'panti_provider.g.dart';

@riverpod
Future<List<Panti>> pantiData(PantiDataRef ref, String cityQuery) async {
  if (cityQuery == '') {
    final pantiListData = await FirebaseFirestore.instance
        .collection('pantiData')
        .where('pantiName', isNotEqualTo: '-')
        .get();
    final List<Panti> resultData = pantiListData.docs
        .map(
          (ss) => Panti(
              pantiName: ss.data()['pantiName'],
              city: ss.data()['city'],
              description: ss.data()['description'],
              numberOfAttendant: ss.data()['numberOfAttendant'],
              numberOfResident: ss.data()['numberOfResident'],
              phoneNumber: ss.data()['phoneNumber'],
              biography: ss.data()['biography'],
              address: ss.data()['address'],
              pengelola: ss.data()['pengelola'],
              est: ss.data()['est'],
              imageUrl: ss.data()['imageUrl'],
              imageList: ss.data()['imageList']),
        )
        .toList();
    return resultData;
  } else {
    final pantiListData = await FirebaseFirestore.instance
        .collection('pantiData')
        .where('city', isEqualTo: cityQuery)
        .get();
    final List<Panti> resultData = pantiListData.docs
        .map(
          (ss) => Panti(
              pantiName: ss.data()['pantiName'],
              city: ss.data()['city'],
              description: ss.data()['description'],
              numberOfAttendant: ss.data()['numberOfAttendant'],
              numberOfResident: ss.data()['numberOfResident'],
              phoneNumber: ss.data()['phoneNumber'],
              biography: ss.data()['biography'],
              address: ss.data()['address'],
              pengelola: ss.data()['pengelola'],
              est: ss.data()['est'],
              imageUrl: ss.data()['imageUrl'],
              imageList: ss.data()['imageList']),
        )
        .toList();
    return resultData;
  }
}

@riverpod
Future<Panti> singlePanti(SinglePantiRef ref, String pantiID) async {
  final pantiResp = await FirebaseFirestore.instance
      .collection('pantiData')
      .doc(pantiID)
      .get();
  final Panti resultData = Panti(
      pantiName: pantiResp.data()!['pantiName'],
      city: pantiResp.data()!['city'],
      description: pantiResp.data()!['description'],
      numberOfAttendant: pantiResp.data()!['numberOfAttendant'],
      numberOfResident: pantiResp.data()!['numberOfResident'],
      phoneNumber: pantiResp.data()!['phoneNumber'],
      biography: pantiResp.data()!['biography'],
      address: pantiResp.data()!['address'],
      pengelola: pantiResp.data()!['pengelola'],
      est: pantiResp.data()!['est'],
      imageUrl: pantiResp.data()!['imageUrl'],
      imageList: pantiResp.data()!['imageList']);
  return resultData;
}

@riverpod
Future<Panti> singlePantiByUser(SinglePantiByUserRef ref, String userID) async {
  final pantiResp = await FirebaseFirestore.instance
      .collection('pantiData')
      .where('userID', isEqualTo: userID)
      .get();
  final Panti resultData = Panti(
      pantiName: pantiResp.docs[0].data()['pantiName'],
      city: pantiResp.docs[0].data()['city'],
      description: pantiResp.docs[0].data()['description'],
      numberOfAttendant: pantiResp.docs[0].data()['numberOfAttendant'],
      numberOfResident: pantiResp.docs[0].data()['numberOfResident'],
      phoneNumber: pantiResp.docs[0].data()['phoneNumber'],
      biography: pantiResp.docs[0].data()['biography'],
      address: pantiResp.docs[0].data()['address'],
      pengelola: pantiResp.docs[0].data()['pengelola'],
      est: pantiResp.docs[0].data()['est'],
      imageUrl: pantiResp.docs[0].data()['imageUrl'],
      imageList: pantiResp.docs[0].data()['imageList']);
  return resultData;
}
