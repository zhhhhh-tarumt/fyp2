import 'package:flutter/material.dart';

class ExpenseSuccessView extends StatelessWidget {
  const ExpenseSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Added"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ICON
            Icon(Icons.check_circle, color: green, size: 100),

            const SizedBox(height: 20),
            const Text(
              "Expense Added Successfully!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            // BUTTONS
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/voiceInput");
                },
                child: const Text("Add an Expense by Voice"),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/addExpense");
                },
                child: Text(
                  "Add an Expense Manually",
                  style: TextStyle(color: green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
