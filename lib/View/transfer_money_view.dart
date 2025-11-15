import 'package:flutter/material.dart';

class TransferMoneyView extends StatelessWidget {
  final amountCtrl = TextEditingController();
  final receiverCtrl = TextEditingController();

  TransferMoneyView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer Money"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 10),

            TextField(
              controller: receiverCtrl,
              decoration: const InputDecoration(
                labelText: "Receiver Phone / Email",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount (RM)",
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              child: const Text("Send Money"),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Payment sent successfully!")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
