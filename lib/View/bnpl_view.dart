import 'package:flutter/material.dart';

class BNPLView extends StatelessWidget {
  const BNPLView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      appBar: AppBar(
        title: const Text("BNPL Tracker"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Your Installments",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  bnplCard("Shopee", "RM 120.00", "2 payments left"),
                  bnplCard("Lazada", "RM 89.00", "1 payment left"),
                  bnplCard("Apple Store", "RM 499.00", "3 payments left"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bnplCard(String title, String amount, String subtitle) {
    return Card(
      color: Colors.green.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: const Icon(Icons.payments, color: Colors.green),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(
          amount,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
