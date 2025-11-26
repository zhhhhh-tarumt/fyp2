import 'package:flutter/material.dart';

class BNPLHistoryView extends StatelessWidget {
  const BNPLHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    final completedItems = [
      {"title": "iPad Air", "date": "Completed • 12 Jan 2025", "amount": "RM 2,300"},
      {"title": "Dining Chair Set", "date": "Completed • 03 Oct 2024", "amount": "RM 590"},
      {"title": "Bluetooth Headphones", "date": "Completed • 22 Aug 2024", "amount": "RM 199"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("BNPL History"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            "Completed BNPL Plans",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: green),
          ),
          const SizedBox(height: 20),

          ...completedItems.map((item) => Container(
                padding: const EdgeInsets.all(18),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green.shade100),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item["title"]!,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: green,
                            )),
                        const SizedBox(height: 4),
                        Text(item["date"]!,
                            style: TextStyle(color: Colors.grey.shade600)),
                      ],
                    ),
                    Text(
                      item["amount"]!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: green, fontSize: 16),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
