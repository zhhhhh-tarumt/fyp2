import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sequence Diagram: isUserExist() / connect()
  Future<String> login(String email, String password) async {
    try {
      // 1. Connect & Authenticate with Firebase
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2. Check if user exists in DB (isUserExist logic)
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        return "Success"; // Status returned to UI
      } else {
        return "User data not found";
      }
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Login Failed";
    } finally {
      // close_connection() is handled automatically by Firebase SDK
    }
  }
}