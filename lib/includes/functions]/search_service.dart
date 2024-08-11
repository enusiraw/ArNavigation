// lib/models/search_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> searchDepartments(String query) async {
    if (query.isEmpty) return [];

    final results = await _firestore
        .collection('departments')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    return results.docs;
  }
}