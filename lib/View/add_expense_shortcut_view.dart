import 'package:flutter/material.dart';

class AddExpenseShortcutView extends StatelessWidget {
  const AddExpenseShortcutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, "/addExpense");
          },
          child: const Text("Add Expense"),
        ),
      ),
    );
  }
}
