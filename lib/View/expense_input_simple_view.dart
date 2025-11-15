import 'package:flutter/material.dart';

class ExpenseInputSimpleView extends StatelessWidget {
  final titleCtrl = TextEditingController();
  final amountCtrl = TextEditingController();

  ExpenseInputSimpleView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quick Expense Input"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 10),

            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: "Expense Title"),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Amount (RM)"),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/expenseSuccess");
              },
              child: const Text("Save Expense"),
            )
          ],
        ),
      ),
    );
  }
}
