import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Service/payment_service.dart';

class DepositController {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _paymentService = PaymentService();

  Future<String> depositMoney(double amount, String method) async {
    try {
      // 1️⃣ create Stripe Intent
      String clientSecret = await _paymentService.createPaymentIntent(amount);

      print("Stripe Client Secret: $clientSecret");

      // 2️⃣ simulate success (later you integrate flutter_stripe for actual payment)
      bool paymentSuccess = true;

      if (!paymentSuccess) return "Payment failed";

      // 3️⃣ update wallet after payment success
      final uid = _auth.currentUser?.uid;
      if (uid == null) return "User not logged in";

      final userDoc = _firestore.collection("users").doc(uid);

      DocumentSnapshot snap = await userDoc.get();
      double current = (snap["walletBalance"] ?? 0).toDouble();

      double updated = current + amount;

      await userDoc.update({"walletBalance": updated});

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
