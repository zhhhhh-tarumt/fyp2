import 'package:flutter/material.dart';

class AIInsightView extends StatelessWidget {
  const AIInsightView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Insights"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              "Your Financial Summary",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),

            const SizedBox(height: 16),

            aiCard("You spent RM 120 on food this week."),
            aiCard("You saved RM 80 more than last month."),
            aiCard("Your bill payments are on track."),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {},
              child: const Text("Ask AI More Questions"),
            ),
          ],
        ),
      ),
    );
  }

  Widget aiCard(String message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Text(message),
    );
  }
}
