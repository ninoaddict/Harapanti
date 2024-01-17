import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
Future<bool> isAdmin(IsAdminRef ref, String userId) async {
  final userData =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
  if (userData.data()!['category'] == 'personal') {
    return false;
  }
  return true;
}
