import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Ensure fl_chart is in pubspec.yaml
import '../Controller/expense_fetcher.dart';

class AnalysisView extends StatefulWidget {
  const AnalysisView({super.key});

  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {
  final ExpenseFetcher _fetcher = ExpenseFetcher();
  
  // Data Variables
  double _totalSpend = 0.0;
  String _topCategory = "None";
  double _savedThisMonth = 0.0;
  String _monthlyChange = "0%";
  Map<String, double> _categoryData = {};
  List<FlSpot> _trendData = [];

  // =========================================================
  // 📊 CALCULATE ANALYTICS
  // =========================================================
  Future<bool> _calculateAnalytics() async {
    // 1. Fetch Expenses (Using the robust Fetcher)
    final expenses = await _fetcher.getAllExpenses();
    
    if (expenses.isEmpty) return true; // No data, stop here

    final now = DateTime.now();

    // 2. Filter for THIS MONTH
    final thisMonthExpenses = expenses.where((e) {
      return _isSameMonth(e.date, now);
    }).toList();

    // 3. Total Spend
    double total = thisMonthExpenses.fold(0, (sum, e) => sum + e.amount);

    // 4. Top Category
    Map<String, double> catMap = {};
    for (var e in thisMonthExpenses) {
      catMap[e.category] = (catMap[e.category] ?? 0) + e.amount;
    }
    String topCat = "None";
    if (catMap.isNotEmpty) {
      var sortedEntries = catMap.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      topCat = sortedEntries.first.key;
    }

    // 5. Monthly Change (Compare vs Last Month)
    final lastMonthDate = DateTime(now.year, now.month - 1, 1);
    final lastMonthExpenses = expenses.where((e) {
      return _isSameMonth(e.date, lastMonthDate);
    }).toList();
    
    double lastTotal = lastMonthExpenses.fold(0, (sum, e) => sum + e.amount);
    String changeStr = "0%";
    if (lastTotal > 0) {
      double change = ((total - lastTotal) / lastTotal) * 100;
      changeStr = "${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}%";
    }

    // 6. Savings (Assumption: Monthly Budget RM 3000)
    double dummyBudget = 3000.0; 
    double saved = dummyBudget - total;

    // 7. Trend Data (Last 6 Months)
    List<FlSpot> spots = [];
    for (int i = 5; i >= 0; i--) {
      DateTime target = DateTime(now.year, now.month - i, 1);
      double monthSum = expenses.where((e) => _isSameMonth(e.date, target))
                                .fold(0, (sum, e) => sum + e.amount);
      spots.add(FlSpot((5 - i).toDouble(), monthSum));
    }

    // Update UI
    if (mounted) {
      setState(() {
        _totalSpend = total;
        _topCategory = topCat;
        _categoryData = catMap;
        _monthlyChange = changeStr;
        _savedThisMonth = saved;
        _trendData = spots;
      });
    }

    return true;
  }

  // Helper: robust date checker
  bool _isSameMonth(String dateStr, DateTime target) {
    try {
      final d = DateTime.parse(dateStr);
      return d.year == target.year && d.month == target.month;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _calculateAnalytics();
  }

  // =========================================================
  // 📱 BUILD UI
  // =========================================================
  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Analytics & Insights"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      // Use RefreshIndicator so user can pull down to reload
      body: RefreshIndicator(
        onRefresh: _calculateAnalytics,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // 1. SUMMARY CARDS
            Row(
              children: [
                Expanded(child: _glassStatCard(Icons.pie_chart_rounded, "Total Spend", "RM ${_totalSpend.toStringAsFixed(0)}", Colors.green)),
                const SizedBox(width: 14),
                Expanded(child: _glassStatCard(Icons.star_rounded, "Top Category", _topCategory, Colors.orange)),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(child: _glassStatCard(Icons.trending_up, "Monthly Change", _monthlyChange, _monthlyChange.contains('+') ? Colors.red : Colors.green)),
                const SizedBox(width: 14),
                Expanded(child: _glassStatCard(Icons.savings, "Savings (Est.)", "RM ${_savedThisMonth.toStringAsFixed(0)}", Colors.teal)),
              ],
            ),

            const SizedBox(height: 30),

            // 2. PIE CHART
            _sectionTitle("Spending Breakdown", green),
            const SizedBox(height: 14),
            _modernChartContainer(
              [Colors.green.shade50, Colors.green.shade100],
              _categoryData.isEmpty 
                ? const Text("No expenses this month")
                : PieChart(PieChartData(sectionsSpace: 2, centerSpaceRadius: 40, sections: _getPieSections())),
            ),

            const SizedBox(height: 30),

            // 3. TREND CHART
            _sectionTitle("6-Month Trend", green),
            const SizedBox(height: 14),
            _modernChartContainer(
              [Colors.blue.shade50, Colors.blue.shade100],
              _trendData.isEmpty
                ? const Text("No data yet")
                : LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false), // Hide axis labels for cleaner look
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: _trendData,
                          isCurved: true,
                          color: Colors.blue.shade800,
                          barWidth: 4,
                          dotData: const FlDotData(show: true),
                          belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
                        ),
                      ],
                    ),
                  ),
            ),
             const SizedBox(height: 30),

             // 4. CATEGORY GRID
             _sectionTitle("Category Details", green),
             const SizedBox(height: 14),
             if (_categoryData.isNotEmpty)
               GridView.builder(
                 shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(),
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.4, crossAxisSpacing: 12, mainAxisSpacing: 12),
                 itemCount: _categoryData.length,
                 itemBuilder: (ctx, i) {
                   String key = _categoryData.keys.elementAt(i);
                   return _categoryCard(key, "RM ${_categoryData[key]!.toStringAsFixed(0)}");
                 },
               ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPERS ---

  Widget _glassStatCard(IconData icon, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0,5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _modernChartContainer(List<Color> colors, Widget child) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0,5))],
      ),
      child: Center(child: child),
    );
  }

  Widget _categoryCard(String title, String amount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(amount, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text, Color color) {
    return Text(text, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold));
  }

  List<PieChartSectionData> _getPieSections() {
    List<Color> colors = [Colors.green, Colors.blue, Colors.orange, Colors.purple, Colors.red];
    int i = 0;
    return _categoryData.entries.map((e) {
      final isLarge = e.value / _totalSpend > 0.3;
      final section = PieChartSectionData(
        color: colors[i++ % colors.length],
        value: e.value,
        title: "${((e.value / _totalSpend) * 100).toStringAsFixed(0)}%",
        radius: isLarge ? 60 : 50,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      );
      return section;
    }).toList();
  }
}