import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/expense_model.dart';

class ExpenseFetcher {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<ExpenseModel>> getAllExpenses() async {
    final uid = auth.currentUser?.uid;
    if (uid == null) return [];

    try {
      // Fetch everything from 'expenses' for this user
      final querySnapshot = await firestore
          .collection("expenses")
          .where("uid", isEqualTo: uid) 
          .get();

      final allExpenses = querySnapshot.docs.map((doc) {
        final data = doc.data();

        // 1. SAFE AMOUNT PARSING (Int vs Double)
        double finalAmount = 0.0;
        if (data["amount"] is int) {
          finalAmount = (data["amount"] as int).toDouble();
        } else if (data["amount"] is double) {
          finalAmount = data["amount"];
        } else if (data["amount"] is String) {
          finalAmount = double.tryParse(data["amount"]) ?? 0.0;
        }

        // 2. SAFE DATE PARSING (String vs Timestamp)
        String finalDate = "";
        if (data["date"] != null) {
          finalDate = data["date"].toString();
        } else if (data["created_at"] != null && data["created_at"] is Timestamp) {
          // Fallback: If 'date' is missing, use 'created_at' from your screenshot
          finalDate = (data["created_at"] as Timestamp).toDate().toString().split('.')[0];
        } else {
          finalDate = DateTime.now().toString().split('.')[0];
        }

        // 3. COMBINE NOTE + TRANSCRIPT
        // If it's a voice note, append the transcript to the note for the AI
        String finalNote = data["note"] ?? "";
        if (data["transcript"] != null && data["transcript"].toString().isNotEmpty) {
           finalNote = "$finalNote (Voice: ${data["transcript"]})";
        }

        return ExpenseModel(
          id: doc.id,
          amount: finalAmount,
          category: data["category"] ?? "Unknown",
          note: finalNote,
          date: finalDate,
          wallet: data["wallet"] ?? "Cash",
          uid: data["uid"] ?? uid,
        );
      }).toList();

      // Sort Newest First
      allExpenses.sort((a, b) => b.date.compareTo(a.date));

      return allExpenses;

    } catch (e) {
      print("Error fetching expenses: $e");
      return [];
    }
  }
}