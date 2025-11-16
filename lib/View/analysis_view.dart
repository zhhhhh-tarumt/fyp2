import 'package:flutter/material.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Analytics & Insights"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ---------------------------------------------------------
          // SUMMARY CARDS
          // ---------------------------------------------------------
          Row(
            children: [
              Expanded(child: _summaryCard("Total Spend", "RM 1,240", green)),
              const SizedBox(width: 12),
              Expanded(child: _summaryCard("Highest Category", "Food", green)),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                  child: _summaryCard("Monthly Change", "+8.4%", Colors.green)),
              const SizedBox(width: 12),
              Expanded(child: _summaryCard("Saved This Month", "RM 310", green)),
            ],
          ),

          const SizedBox(height: 30),

          // ---------------------------------------------------------
          // PIE CHART AREA
          // ---------------------------------------------------------
          Text(
            "Spending Breakdown",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: green),
          ),
          const SizedBox(height: 12),

          Container(
            height: 220,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: const Center(
              child: Text(
                "Pie Chart Coming Soon",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // ---------------------------------------------------------
          // TREND LINE CHART
          // ---------------------------------------------------------
          Text(
            "Spending Trend (6 Months)",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: green),
          ),
          const SizedBox(height: 12),

          Container(
            height: 220,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: const Center(
              child: Text(
                "Line Chart Coming Soon",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // ---------------------------------------------------------
          // CATEGORY GRID
          // ---------------------------------------------------------
          Text(
            "Top Categories",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: green),
          ),
          const SizedBox(height: 16),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.3,
            children: [
              _categoryCard("Food", "RM 320", Icons.fastfood),
              _categoryCard("Transport", "RM 140", Icons.directions_car),
              _categoryCard("Shopping", "RM 280", Icons.shopping_bag),
              _categoryCard("Bills", "RM 500", Icons.receipt_long),
            ],
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // =======================================================================
  // REUSABLE UI COMPONENTS
  // =======================================================================

  Widget _summaryCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryCard(String title, String amount, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.green.shade800, size: 38),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900),
          ),
          const SizedBox(height: 6),
          Text(
            amount,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}