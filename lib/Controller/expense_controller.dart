import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/expense_model.dart';
import '../Model/expense_voice_model.dart';

class ExpenseController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 1. Manual Add (FIXED)
  Future<String> addExpense(ExpenseModel expense) async {
    try {
      final doc = _firestore.collection("expenses").doc();
      
      // Convert model to map
      final data = expense.toMap();
      
      // 🔥 FIX 1: Add created_at for sorting
      data['created_at'] = FieldValue.serverTimestamp();
      
      // 🔥 FIX 2: Ensure ID matches document ID
      data['id'] = doc.id;

      await doc.set(data);
      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  // 2. Voice Add (Already Correct)
  Future<String> addVoiceExpense(ExpenseVoiceModel voiceModel) async {
    // ... (Keep your existing working code here)
    final user = _auth.currentUser;
    if (user == null) return "User not logged in";

    try {
      final doc = _firestore.collection("expenses").doc(); 
      
      final dataToSave = {
        "id": doc.id,
        "amount": voiceModel.amount,
        "category": voiceModel.category,
        "note": "${voiceModel.note} (Voice: ${voiceModel.transcript})",
        "transcript": voiceModel.transcript,
        "offlineFallback": voiceModel.offlineFallback,
        "uid": user.uid, 
        "date": DateTime.now().toString().split('.')[0], 
        "created_at": FieldValue.serverTimestamp(),
        "wallet": "Voice Wallet",
      };

      await doc.set(dataToSave);
      return "success";
    } catch (e) {
      return "Error saving voice: $e";
    }
  }
}