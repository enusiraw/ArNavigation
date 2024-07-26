import 'package:ar_navigation/model/departments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String COLLECTIONS_REF_ = 'buildings';

class DatabaseSercices {
  final firestore = FirebaseFirestore.instance;
  late CollectionReference _buildings;

  DatabaseSercices() {
    _buildings = firestore
        .collection(COLLECTIONS_REF_)
        .withConverter<Departments>(
            fromFirestore: (snapshots, _) =>
                Departments.fromJson(snapshots.data()!),
            toFirestore: (departments, _) => departments.toJson());
  }
  Stream<QuerySnapshot> getDetails() {
    return _buildings.snapshots();
  }
}
