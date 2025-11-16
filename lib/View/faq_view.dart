import 'package:flutter/material.dart';

class FAQView extends StatelessWidget {
  const FAQView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    final faqs = [
      {
        "q": "What is BudgetMate?",
        "a":
            "BudgetMate is a personal finance tracker that helps you manage expenses, BNPL instalments, and get AI-powered insights on your spending."
      },
      {
        "q": "Is my data safe?",
        "a":
            "Your data is stored securely in the cloud. In a real deployment, BudgetMate would use secure authentication and encryption best practices."
      },
      {
        "q": "Can I sync across multiple devices?",
        "a":
            "Yes. As a cross-platform Flutter app, BudgetMate can sync your data across Android, iOS, and web (with proper backend setup)."
      },
      {
        "q": "What is BNPL tracking?",
        "a":
            "BNPL tracking allows you to monitor your instalment plans from platforms like SPayLater, Atome, and other Buy-Now-Pay-Later services."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            "Frequently Asked Questions",
            style: TextStyle(
              color: green,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Find quick answers about how BudgetMate works.",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),

          ...faqs.map((item) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.green.shade100),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  tilePadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  childrenPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  title: Text(
                    item["q"]!,
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  iconColor: green,
                  collapsedIconColor: Colors.green.shade700,
                  children: [
                    Text(
                      item["a"]!,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
