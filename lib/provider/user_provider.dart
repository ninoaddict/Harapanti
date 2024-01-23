import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:harapanti/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:io';

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

@riverpod
class UserInfo extends _$UserInfo {
  @override
  Future<UserModel> build(String userID) async {
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();

    UserModel result = UserModel(
      category: userData['category'],
      email: userData['email'],
      imageUrl: userData['imageUrl'],
      username: userData['username'],
    );

    return result;
  }

  Future<void> updateData(
    String userID,
    String fullName,
    File? pickedImage,
  ) async {
    Map<String, dynamic>? data;

    if (pickedImage == null) {
      data = {'username': fullName};
    } else {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('$userID.jpg');
      await storageRef.putFile(pickedImage);
      data = {'username': fullName};
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .update(data);

    ref.invalidateSelf();
    await future;
  }
}
