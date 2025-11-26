import 'dart:ui';
import 'package:flutter/material.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Analytics & Insights"),
        centerTitle: true,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),

          // ============================================================
          // TOP GLASS SUMMARY CARDS — LUXURY FINTECH STYLE
          // ============================================================
          Row(
            children: [
              Expanded(
                child: _glassStatCard(
                  icon: Icons.pie_chart_rounded,
                  label: "Total Spend",
                  value: "RM 1,240",
                  iconColor: Colors.green,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _glassStatCard(
                  icon: Icons.fastfood_rounded,
                  label: "Top Category",
                  value: "Food",
                  iconColor: Colors.orange,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: _glassStatCard(
                  icon: Icons.trending_up_rounded,
                  label: "Monthly Change",
                  value: "+8.4%",
                  iconColor: Colors.blue,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _glassStatCard(
                  icon: Icons.savings_rounded,
                  label: "Saved This Month",
                  value: "RM 310",
                  iconColor: Colors.teal,
                ),
              ),
            ],
          ),

          const SizedBox(height: 35),

          // ============================================================
          // MODERN CHART CONTAINERS (glass + gradient)
          // ============================================================
          _sectionTitle("Spending Breakdown", green),
          const SizedBox(height: 14),

          _modernChartContainer(
            gradientColors: [
              Colors.green.shade50,
              Colors.green.shade100,
            ],
            child: const Text(
              "Pie Chart Coming Soon",
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),

          const SizedBox(height: 35),

          _sectionTitle("6-Month Trend", green),
          const SizedBox(height: 14),

          _modernChartContainer(
            gradientColors: [
              Colors.blue.shade50,
              Colors.blue.shade100,
            ],
            child: const Text(
              "Line Chart Coming Soon",
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),

          const SizedBox(height: 35),

          // ============================================================
          // MODERN CATEGORY GRID — LARGE ICON + CLEAN
          // ============================================================
          _sectionTitle("Top Categories", green),
          const SizedBox(height: 16),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.25,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _categoryCard("Food", "RM 320", Icons.fastfood_rounded),
              _categoryCard("Transport", "RM 140", Icons.directions_car_filled),
              _categoryCard("Shopping", "RM 280", Icons.shopping_bag_rounded),
              _categoryCard("Bills", "RM 500", Icons.receipt_long_rounded),
            ],
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }

  // ======================================================================
  // ✨ GLASS EFFECT SUMMARY CARD (Revolut Style)
  // ======================================================================
  Widget _glassStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.65),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconColor.withOpacity(0.15),
                ),
                child: Icon(icon, color: iconColor, size: 26),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      color: iconColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ======================================================================
  // ✨ MODERN CHART CONTAINER (gradient + shadow)
  // ======================================================================
  Widget _modernChartContainer({
    required List<Color> gradientColors,
    required Widget child,
  }) {
    return Container(
      height: 240,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }

  // ======================================================================
  // ✨ CATEGORY CARD — float effect
  // ======================================================================
  Widget _categoryCard(String title, String amount, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.green.shade800),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: Colors.green.shade900,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(amount, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  // ======================================================================
  // SECTION TITLE
  // ======================================================================
  Widget _sectionTitle(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 22,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
