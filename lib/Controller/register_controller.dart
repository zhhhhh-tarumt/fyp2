import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/user_model.dart';

class RegisterController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sequence Diagram: check_duplication()
  Future<bool> checkDuplication(String email) async {
    final query = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return query.docs.isNotEmpty; // Returns true if duplicate exists
  }

  // Sequence Diagram: savedUser()
  Future<String> registerUser(String username, String email, String phone, String password) async {
    try {
      // 1. Check duplication
      bool isDuplicate = await checkDuplication(email);
      if (isDuplicate) return "User already exists";

      // 2. Create Auth User
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 3. Save User to DB
      UserModel newUser = UserModel(
        userId: cred.user!.uid,
        username: username,
        email: email,
        phoneNumber: phone,
        password: password, // Note: Firebase Auth handles auth, this is for profile data
      );

      await _firestore.collection('users').doc(cred.user!.uid).set(newUser.toMap());
      
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }
}