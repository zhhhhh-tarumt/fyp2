import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransferController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> transferMoney({
    required double amount,
    required String receiverPhone,
    required String note,
  }) async {
    try {
      final senderId = _auth.currentUser?.uid;
      if (senderId == null) return "User not logged in";

      // Get sender info
      final senderDoc = await _firestore.collection("users").doc(senderId).get();
      final senderPhone = senderDoc["phoneNumber"];
      double senderBalance = senderDoc["walletBalance"].toDouble();

      // ⛔ Prevent self-transfer
      if (senderPhone == receiverPhone) {
        return "You cannot transfer to yourself";
      }

      if (senderBalance < amount) {
        return "Insufficient balance";
      }

      // Find receiver
      final receiverQuery = await _firestore
          .collection("users")
          .where("phoneNumber", isEqualTo: receiverPhone)
          .limit(1)
          .get();

      if (receiverQuery.docs.isEmpty) return "Receiver not found";

      final receiverDoc = receiverQuery.docs.first;
      final receiverId = receiverDoc.id;
      double receiverBalance = receiverDoc["walletBalance"].toDouble();

      // Update balances
      await _firestore.collection("users").doc(senderId).update({
        "walletBalance": senderBalance - amount,
      });

      await _firestore.collection("users").doc(receiverId).update({
        "walletBalance": receiverBalance + amount,
      });

      // Save history
      await _firestore
          .collection("users")
          .doc(senderId)
          .collection("transfer_history")
          .add({
        "to": receiverPhone,
        "amount": amount,
        "note": note,
        "timestamp": FieldValue.serverTimestamp(),
      });

      await _firestore
          .collection("users")
          .doc(receiverId)
          .collection("received_history")
          .add({
        "from": senderPhone,
        "amount": amount,
        "note": note,
        "timestamp": FieldValue.serverTimestamp(),
      });

      return "success";
    } catch (e) {
      return e.toString();
    }
  }
}
