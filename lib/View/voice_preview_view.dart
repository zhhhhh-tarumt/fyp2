import 'package:flutter/material.dart';

class VoicePreviewView extends StatefulWidget {
  const VoicePreviewView({super.key});

  @override
  State<VoicePreviewView> createState() => _VoicePreviewViewState();
}

class _VoicePreviewViewState extends State<VoicePreviewView> {
  final amount = TextEditingController(text: "12.50");
  final merchant = TextEditingController(text: "McDonald's");
  final desc = TextEditingController(text: "Lunch");
  String category = "Food";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Preview Expense")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Extracted from Voice Input:",
                style: TextStyle(fontSize: 18)),

            const SizedBox(height: 20),
            TextField(controller: amount, decoration: const InputDecoration(labelText: "Amount")),
            TextField(controller: merchant, decoration: const InputDecoration(labelText: "Merchant")),
            TextField(controller: desc, decoration: const InputDecoration(labelText: "Description")),

            const SizedBox(height: 20),
            DropdownButton<String>(
              value: category,
              isExpanded: true,
              items: ["Food", "Transport", "Shopping", "Bills", "Groceries"]
                  .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: (val) => setState(() => category = val!),
            ),

            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/expenseSuccess"),
              child: const Text("Save Expense"),
            ),
          ],
        ),
      ),
    );
  }
}
