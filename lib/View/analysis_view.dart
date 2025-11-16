import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Analysis",
          style: TextStyle(color: Colors.black),
        ),
      ),

<<<<<<< Updated upstream
      body: SingleChildScrollView(
=======
      body: ListView(
>>>>>>> Stashed changes
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Spending Trend",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            /// LINE CHART (Monthly Trend)
            Container(
              height: 220,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          const labels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
                          if (value.toInt() >= 0 && value.toInt() < labels.length) {
                            return Text(labels[value.toInt()]);
                          }
                          return const Text("");
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: Colors.blueAccent,
                      barWidth: 4,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blueAccent.withOpacity(0.2),
                      ),
                      spots: const [
                        FlSpot(0, 200),
                        FlSpot(1, 320),
                        FlSpot(2, 250),
                        FlSpot(3, 410),
                        FlSpot(4, 390),
                        FlSpot(5, 500),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Category Breakdown",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            /// PIE CHART (Spending Categories)
            Container(
              height: 260,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: PieChart(
                PieChartData(
                  sectionsSpace: 3,
                  centerSpaceRadius: 40,
                  sections: [
                    PieChartSectionData(
                      value: 30,
                      color: Colors.blueAccent,
                      title: "Food",
                      radius: 55,
                      titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    PieChartSectionData(
                      value: 25,
                      color: Colors.orangeAccent,
                      title: "Transport",
                      radius: 55,
                      titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    PieChartSectionData(
                      value: 20,
                      color: Colors.green,
                      title: "Shopping",
                      radius: 55,
                      titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    PieChartSectionData(
                      value: 25,
                      color: Colors.purpleAccent,
                      title: "Bills",
                      radius: 55,
                      titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Top Spending Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            _categoryItem("Food & Drinks", "RM 430.00", Colors.blueAccent),
            _categoryItem("Shopping", "RM 310.00", Colors.green),
            _categoryItem("Bills", "RM 200.00", Colors.purpleAccent),
            _categoryItem("Transport", "RM 120.00", Colors.orangeAccent),
          ],
        ),
      ),
    );
  }

  Widget _categoryItem(String title, String amount, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
<<<<<<< Updated upstream
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(Icons.circle, size: 16, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
=======
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
>>>>>>> Stashed changes
        ],
      ),
    );
  }
}
