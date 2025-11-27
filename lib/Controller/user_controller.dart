import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/user_model.dart';

class UserController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ============================================================
  // GET REAL-TIME WALLET BALANCE STREAM
  // ============================================================
  Stream<double> walletBalanceStream() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    return _firestore
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((snap) {
      if (!snap.exists) return 0.0;
      return (snap.data()?["walletBalance"] ?? 0).toDouble();
    });
  }

  // ============================================================
  // FETCH FULL USER MODEL
  // ============================================================
  Future<UserModel?> fetchCurrentUser() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return null;

      final snap = await _firestore.collection("users").doc(uid).get();

      if (!snap.exists) return null;

      return UserModel.fromMap(snap.data()!, uid);
    } catch (e) {
      print("Error loading user: $e");
      return null;
    }
  }

  // ============================================================
  // UPDATE WALLET BALANCE (deposit, transfer, expense)
  // ============================================================
  Future<void> updateWalletBalance(double newBalance) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore.collection("users").doc(uid).update({
      "walletBalance": newBalance,
    });
  }
}
