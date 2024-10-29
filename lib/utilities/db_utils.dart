import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBUtils {
  // Method to get the current user from Firebase
  static Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  // Method to get the user's email
  static Future<String?> getUserEmail() async {
    final user = await getCurrentUser();
    return user?.email;
  }

  // Method to get the first name from the email
  static Future<String?> getFirstName() async {
    final email = await getUserEmail();
    if (email == null) return null;
    final localPart = email.split('@')[0];
    final firstName = localPart.split('.')[0];
    return capitalizeFirstLetter(firstName);
  }

  // Helper method to capitalize the first letter
  static String capitalizeFirstLetter(String string) {
    return string[0].toUpperCase() + string.substring(1).toLowerCase();
  }

  // Method to search departments in Firestore
  static Stream<List<QueryDocumentSnapshot>> searchDepartments(
      String searchTerm) {
    return FirebaseFirestore.instance
        .collection('departments')
        .where('name', isGreaterThanOrEqualTo: searchTerm)
        .where('name', isLessThanOrEqualTo: '$searchTerm\uf8ff')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.where((doc) {
        final data = doc.data();
        final name = data['name'] as String;
        return name.toLowerCase().contains(searchTerm.toLowerCase());
      }).toList();
    });
  }
}
