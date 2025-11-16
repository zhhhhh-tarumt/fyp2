import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      appBar: AppBar(
        title: const Text("About BudgetMate"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER CARD WITH LOGO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.green.shade100),
              ),
              child: Column(
                children: [
                  Image.asset("assets/images/kangaroo.png", height: 95),
                  const SizedBox(height: 15),
                  Text(
                    "BudgetMate",
                    style: TextStyle(
                      fontSize: 28,
                      color: green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Track Smarter. Spend Better.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // OVERVIEW
            Text(
              "Your Financial Companion",
              style: TextStyle(
                color: green,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "BudgetMate helps you take control of your finances with simplicity and intelligence. "
              "From tracking daily expenses to receiving AI-powered insights, BudgetMate makes money management effortless and enjoyable.",
              style: const TextStyle(fontSize: 15, height: 1.45),
            ),

            const SizedBox(height: 25),

            // FEATURES
            Text(
              "Core Features",
              style: TextStyle(
                color: green,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            featureTile(Icons.analytics, "Smart Spending Insights",
                "Get AI-driven analysis to understand your spending habits."),
            featureTile(Icons.mic, "Voice Expense Input",
                "Add expenses instantly with accurate speech-to-text."),
            featureTile(Icons.payments, "BNPL Instalment Tracking",
                "Keep track of all instalments in one place."),
            featureTile(Icons.qr_code_scanner, "Merchant Scan",
                "Scan merchant bills or QR for quick expense entry."),
            featureTile(Icons.show_chart, "Real-Time Dashboard",
                "Visual breakdown of expenses, categories, and trends."),
            featureTile(Icons.account_balance_wallet, "Smart Expense Management",
                "Auto categorisation and recurring expense detection."),
            featureTile(Icons.sync, "Cloud Sync",
                "Your data stays safe and updated across devices."),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  Widget featureTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.green.shade800, size: 32),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green.shade900,
          ),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}
