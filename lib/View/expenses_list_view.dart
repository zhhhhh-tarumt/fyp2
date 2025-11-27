import 'package:flutter/material.dart';

class ExpensesListView extends StatelessWidget {
  const ExpensesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Expenses"),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 10, // replace with your controller count
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.shopping_bag, size: 30, color: Colors.green.shade800),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Expense ${index + 1}",
                          style: TextStyle(
                              color: Colors.green.shade900,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("Category: Food",
                          style: TextStyle(color: Colors.grey.shade600)),
                    ],
                  ),
                ),
                Text("RM ${((index + 1) * 5).toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Colors.green.shade900,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          );
        },
      ),
    );
  }
}
