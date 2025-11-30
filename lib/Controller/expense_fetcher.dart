import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/expense_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseFetcher {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<ExpenseModel>> getUserExpenses() async {
    final uid = auth.currentUser?.uid;
    if (uid == null) return [];

    final snapshot = await firestore
        .collection("expenses")
        .where("uid", isEqualTo: uid)
        .get();

    return snapshot.docs.map((doc) {
      return ExpenseModel(
        id: doc.id,
        amount: (doc["amount"] ?? 0).toDouble(),
        category: doc["category"] ?? "Unknown",
        note: doc["note"] ?? "",
        date: doc["date"] ?? "",
        wallet: doc["wallet"] ?? "",
        uid: doc["uid"] ?? "",
      );
    }).toList();
  }
}
