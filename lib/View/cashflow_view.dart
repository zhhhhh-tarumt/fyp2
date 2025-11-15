import 'package:flutter/material.dart';

class CashFlowView extends StatelessWidget {
  const CashFlowView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cash Flow"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // PIE CHART PLACEHOLDER
          Center(
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green.shade200),
              ),
              child: const Center(
                child: Text("Pie Chart"),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Today
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.green.shade50,
            child: Text(
              "Today",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                transactionTile("Food & Drink", "-RM 21.00"),
                transactionTile("Transport", "-RM 9.00"),
                transactionTile("Shopping", "-RM 40.00"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget transactionTile(String title, String amount) {
    return ListTile(
      leading: const Icon(Icons.circle, size: 12, color: Colors.green),
      title: Text(title),
      trailing: Text(
        amount,
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
