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
  String selectedCategory = "Select category";

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a Transaction"),
        centerTitle: true,
      ),

      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // AMOUNT
            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: "0.00",
                border: InputBorder.none,
              ),
            ),

            const SizedBox(height: 20),

            // Wallet Row
            listRow(
              icon: Icons.account_balance_wallet,
              label: "Wallet",
              value: selectedWallet,
              onPressed: () {},
            ),

            // Date Row
            listRow(
              icon: Icons.calendar_today,
              label: "Date",
              value: selectedDate,
              onPressed: () {},
            ),

            // Notes
            listRow(
              icon: Icons.edit,
              label: "Notes",
              value: noteCtrl.text.isEmpty ? "Enter notes" : noteCtrl.text,
              onPressed: () {},
            ),

            // Category
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/selectCategory");
              },
              child: listRow(
                icon: Icons.category,
                label: "Category",
                value: selectedCategory,
                onPressed: () {},
              ),
            ),

            const Spacer(),

            // BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/expenseSuccess");
                },
                child: const Text("Add Transaction"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listRow({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.green.shade700),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const Divider(height: 25),
      ],
    );
  }
}
