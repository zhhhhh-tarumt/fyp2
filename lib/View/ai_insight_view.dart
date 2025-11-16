import 'package:flutter/material.dart';

class AIInsightView extends StatelessWidget {
  const AIInsightView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("AI Insights"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // ----------------------------------------------------------
          // HEADER WITH AI ICON
          // ----------------------------------------------------------
          Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade600,
                  Colors.green.shade900,
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
            child: Column(
              children: [
                Icon(Icons.auto_awesome, size: 60, color: Colors.white),
                const SizedBox(height: 10),
                Text(
                  "Your Smart Financial Assistant",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  "AI-powered insights based on your spending habits.",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ----------------------------------------------------------
          // INSIGHT CONTENT
          // ----------------------------------------------------------
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle("This Week’s Summary", green),
                  aiInsightCard(
                    icon: Icons.restaurant_menu,
                    title: "Food Spending",
                    message: "You spent RM 120 on food this week.",
                    change: "+12%",
                    trendUp: true,
                  ),
                  aiInsightCard(
                    icon: Icons.donut_large,
                    title: "Savings Trend",
                    message: "You saved RM 80 more than last month.",
                    change: "+18%",
                    trendUp: true,
                  ),
                  aiInsightCard(
                    icon: Icons.receipt_long,
                    title: "Bills & Subscriptions",
                    message: "Your monthly bills are fully on track.",
                    change: "0%",
                    trendUp: false,
                  ),

                  const SizedBox(height: 30),

                  _sectionTitle("Smart Recommendations", green),
                  suggestionCard(
                    "Reduce Food Delivery",
                    "You spent RM 65 on delivery fees. Consider cooking more to save RM 200/month.",
                  ),
                  suggestionCard(
                    "Subscription Cleanup",
                    "You have 3 unused subscriptions. Cancelling them saves RM 45/month.",
                  ),
                  suggestionCard(
                    "Better Savings Plan",
                    "You can save an extra RM 150/month by adjusting your daily spending limit.",
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),

      // ----------------------------------------------------------
      // FLOATING AI ASK BAR
      // ----------------------------------------------------------
      bottomNavigationBar: _aiAskBar(context),
    );
  }

  // SECTION TITLE
  Widget _sectionTitle(String text, Color green) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          color: green,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // AI INSIGHT CARD
  // ----------------------------------------------------------
  Widget aiInsightCard({
    required IconData icon,
    required String title,
    required String message,
    required String change,
    required bool trendUp,
  }) {
    final color = trendUp ? Colors.green.shade700 : Colors.red.shade700;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, size: 34, color: Colors.green.shade900),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(message),
              ],
            ),
          ),

          Column(
            children: [
              Icon(
                trendUp ? Icons.trending_up : Icons.trending_down,
                color: color,
              ),
              Text(
                change,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // RECOMMENDATION CARD
  // ----------------------------------------------------------
  Widget suggestionCard(String title, String message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade100.withOpacity(0.5),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                color: Colors.green.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          const SizedBox(height: 4),
          Text(
            message,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // AI ASK BAR
  // ----------------------------------------------------------
  Widget _aiAskBar(BuildContext context) {
    final green = Colors.green.shade900;
    final controller = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        border: Border(
          top: BorderSide(color: Colors.green.shade300),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Ask BudgetMate AI...",
                border: InputBorder.none,
              ),
            ),
          ),

          IconButton(
            icon: Icon(Icons.send, color: green),
            onPressed: () {
              if (controller.text.trim().isEmpty) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("AI is processing: ${controller.text}"),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
