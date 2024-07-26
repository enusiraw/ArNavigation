import 'package:cloud_firestore/cloud_firestore.dart';

Future<GeoPoint> getOfficeLocation() async {
  int retries = 3;
  while (retries > 0) {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('office-location')
          .doc('main_office')
          .get();

      if (doc.exists) {
        return doc['location'];
      } else {
        throw Exception("Office location not found");
      }
    } catch (e) {
      print("Error retrieving location: $e");
      retries--;
      await Future.delayed(Duration(seconds: 2));
    }
  }
  throw Exception("Failed to retrieve office location after retries");
}
