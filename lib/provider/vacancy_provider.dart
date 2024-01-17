import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vacancy_provider.g.dart';

@riverpod
class VacancyList extends _$VacancyList {
  @override
  Future<List<Map<String, dynamic>>> build() async {
    final pantiListData =
        await FirebaseFirestore.instance.collection('vacancy').get();
    final List<Map<String, dynamic>> resultData =
        pantiListData.docs.map((ss) => ss.data()).toList();
    return resultData;
  }
}
