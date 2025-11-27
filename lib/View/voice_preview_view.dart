import 'package:flutter/material.dart';
import '../Model/expense_voice_model.dart';

class VoicePreviewView extends StatelessWidget {
  const VoicePreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final ExpenseVoiceModel data =
        ModalRoute.of(context)!.settings.arguments as ExpenseVoiceModel;

    return Scaffold(
      appBar: AppBar(title: const Text("Confirm Expense")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Title: ${data.title}", style: const TextStyle(fontSize: 18)),
            Text("Amount: RM ${data.amount}", style: const TextStyle(fontSize: 18)),
            Text("Category: ${data.category}", style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                // call your add expense DAO
              },
              child: const Text("Save Expense"),
            )
          ],
        ),
      ),
    );
  }
}
