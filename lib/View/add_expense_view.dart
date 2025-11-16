import 'dart:ui';
import 'package:flutter/material.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({super.key});

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  final amountCtrl = TextEditingController();
  final noteCtrl = TextEditingController();

  String selectedWallet = "Wallet 1";
  String selectedDate = "Today";
  String selectedCategory = "Select Category";

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;
    final screenHeight = MediaQuery.of(context).size.height;

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
            SizedBox(height: screenHeight * 0.01),

            // ======================================================
            // AMOUNT INPUT (Beautiful Modern Style)
            // ======================================================
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
                  Text(
                    "RM",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: green,
                    ),
                  ),
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
                        hintStyle: TextStyle(
                          fontSize: 38,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            // ======================================================
            // SELECTION CARDS (Wallet / Date / Notes / Category)
            // ======================================================
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

            GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/selectCategory"),
              child: _optionCard(
                icon: Icons.category,
                label: "Category",
                value: selectedCategory,
                onTap: () {},
              ),
            ),

            SizedBox(height: screenHeight * 0.15),

            // ======================================================
            // ADD TRANSACTION BUTTON
            // ======================================================
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
                onPressed: () {
                  Navigator.pushNamed(context, "/expenseSuccess");
                },
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

  // ======================================================
  // SECTION TITLE
  // ======================================================
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

  // ======================================================
  // OPTION CARD (Wallet, Date, Notes, Category)
  // ======================================================
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
            offset: const Offset(0, 3),
          )
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
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
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
