import 'dart:ui';
import 'package:flutter/material.dart';

import '../Controller/expense_controller.dart';
import '../Controller/user_controller.dart';
import '../Model/expense_model.dart';
import '../Model/user_model.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({super.key});

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  final amountCtrl = TextEditingController();
  final noteCtrl = TextEditingController();

  String selectedWallet = "Main Wallet";
  String selectedDate = "Today";
  String selectedCategory = "Select Category";

  final ExpenseController expenseController = ExpenseController();
  final UserController userController = UserController();

  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    currentUser = await userController.fetchCurrentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;
    final height = MediaQuery.of(context).size.height;

    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Add Expense"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.01),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("RM",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: green)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: amountCtrl,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: green,
                      ),
                      decoration: const InputDecoration(
                        hintText: "0.00",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.03),

            _sectionTitle("Transaction Details", green),
            const SizedBox(height: 10),

            _optionCard(
              icon: Icons.account_balance_wallet,
              label: "Wallet",
              value: selectedWallet,
              onTap: () {},
            ),

            _optionCard(
              icon: Icons.calendar_today,
              label: "Date",
              value: selectedDate,
              onTap: () {},
            ),

            _optionCard(
              icon: Icons.edit_note,
              label: "Notes",
              value: noteCtrl.text.isEmpty ? "Add notes" : noteCtrl.text,
              onTap: () {},
            ),

            // FIXED CATEGORY SELECTION
            GestureDetector(
              onTap: () async {
                final result = await Navigator.pushNamed(context, "/selectCategory");

                if (result != null) {
                  setState(() {
                    selectedCategory = result.toString();
                  });
                }
              },
              child: _optionCard(
                icon: Icons.category,
                label: "Category",
                value: selectedCategory,
                onTap: () {},
              ),
            ),

            SizedBox(height: height * 0.15),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: saveExpense,
                child: const Text(
                  "Add Transaction",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveExpense() async {
    double amount = double.tryParse(amountCtrl.text) ?? 0;

    if (amount <= 0 || selectedCategory == "Select Category") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all fields")),
      );
      return;
    }

    final expense = ExpenseModel(
      id: "",
      amount: amount,
      category: selectedCategory,
      note: noteCtrl.text,
      date: selectedDate,
      wallet: selectedWallet,
      uid: currentUser!.userId,
    );

    final result = await expenseController.addExpense(expense);

    if (result == "success") {
      Navigator.pushNamed(context, "/expenseSuccess");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  Widget _sectionTitle(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _optionCard({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.green.shade800, size: 26),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
              const SizedBox(height: 3),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade900,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
