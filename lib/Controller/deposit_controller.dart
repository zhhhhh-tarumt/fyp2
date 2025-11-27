import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DepositController {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Deposit money into user wallet
  Future<String> depositMoney(double amount, String method) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return "User not logged in";

      final userDoc = _firestore.collection("users").doc(uid);

      // Get current wallet balance
      DocumentSnapshot snap = await userDoc.get();
      double current = (snap["walletBalance"] ?? 0).toDouble();

      // New balance
      double updated = current + amount;

      // Update wallet balance
      await userDoc.update({"walletBalance": updated});

      // Add transaction history
      await userDoc.collection("wallet_history").add({
        "type": "deposit",
        "amount": amount,
        "method": method,
        "timestamp": FieldValue.serverTimestamp(),
      });

      return "success";
    } catch (e) {
      return e.toString();
    }
  }
}
