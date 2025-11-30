import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Model/expense_voice_model.dart';

class ExpenseFormView extends StatefulWidget {
  const ExpenseFormView({super.key});

  @override
  State<ExpenseFormView> createState() => _ExpenseFormViewState();
}

class _ExpenseFormViewState extends State<ExpenseFormView> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _amountCtrl;
  late TextEditingController _noteCtrl;
  String _selectedCategory = "Others";

  final List<String> categories = [
    "Food & Drinks",
    "Transport",
    "Shopping",
    "Bills & Utilities",
    "Entertainment",
    "Groceries",
    "Education",
    "Health",
    "Others",
    "No Detect",
  ];

  bool isSaving = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ExpenseVoiceModel data =
        ModalRoute.of(context)!.settings.arguments as ExpenseVoiceModel;

    _amountCtrl =
        TextEditingController(text: data.amount.toStringAsFixed(2));
    _noteCtrl = TextEditingController(text: data.note);
    _selectedCategory = categories.contains(data.category)
        ? data.category
        : "Others";
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Confirm Expense"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Amount
              TextFormField(
                controller: _amountCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "Amount (RM)",
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return "Please enter amount";
                  }
                  final parsed = double.tryParse(val);
                  if (parsed == null || parsed < 0) {
                    return "Invalid amount";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // Category dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: categories
                    .map(
                      (c) => DropdownMenuItem(
                        value: c,
                        child: Text(c),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedCategory = val;
                    });
                  }
                },
              ),

              const SizedBox(height: 15),

              // Note
              TextFormField(
                controller: _noteCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Note / Description",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: isSaving ? null : _saveExpense,
                  child: isSaving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Save Expense",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveExpense() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSaving = true);

    final amount = double.parse(_amountCtrl.text.trim());
    final note = _noteCtrl.text.trim();
    final category = _selectedCategory;
    final firstWord = _extractFirstWord(note);
    final user = FirebaseAuth.instance.currentUser; // Get User

    try {
      await FirebaseFirestore.instance.collection("expenses").add({
        "amount": amount,
        "category": category,
        "note": note,
        "firstWord": firstWord,
        
        // 🔥 FIX 1: Add UID
        "uid": user?.uid ?? "", 
        
        // 🔥 FIX 2: Add Date String for Analysis Page
        "date": DateTime.now().toString().split('.')[0], 
        
        "created_at": FieldValue.serverTimestamp(),
        "source": "voice_ai_form",
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Expense saved successfully")),
      );
      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      // ... error handling
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  String? _extractFirstWord(String note) {
    final parts = note.trim().split(RegExp(r"\s+"));
    if (parts.isEmpty) return null;
    return parts.first.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
  }
}