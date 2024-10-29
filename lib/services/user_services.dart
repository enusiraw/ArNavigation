import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<UserCredential?> registerUser(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _db.collection("users").doc(userCredential.user!.uid).set({
        "Name": name,
        "Email": email,
      });

      return userCredential; 
    } on FirebaseAuthException catch (e) {
      
      print("Error: $e");
      return null;
    }
  }

   Future<UserCredential?> loginUser(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Optionally fetch user data from Firestore
      await _db.collection("users").doc(userCredential.user!.uid).get();

      return userCredential; // Return the user credential on success
    } on FirebaseAuthException catch (e) {
      // Handle exceptions and return null
      print(e.message);
      return null;
    }
  }
}
