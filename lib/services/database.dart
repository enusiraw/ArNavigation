import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseSercices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List> getDepartments() async {
    try {
      QuerySnapshot snapshot = await _db.collection('departments').get();
      List departments = snapshot.docs.map((doc) {
        return doc['name'];
      }).toList();
      return departments;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
