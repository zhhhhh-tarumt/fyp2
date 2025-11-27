import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/expense_model.dart';

class ExpenseController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addExpense(ExpenseModel expense) async {
    try {
      final doc = _firestore.collection("expenses").doc();
      expense.id = doc.id; // auto-generated ID

      await doc.set(expense.toMap());

      return "success";
    } catch (e) {
      return e.toString();
    }
  }
}
