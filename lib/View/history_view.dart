import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transaction History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      backgroundColor: Colors.grey.shade100,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          // ---------------------------------------------------
          // FILTER BAR (Today / Week / Month)
          // ---------------------------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _filterChip("Today", true),
                _filterChip("Week", false),
                _filterChip("Month", false),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ---------------------------------------------------
          // TRANSACTION LIST
          // ---------------------------------------------------
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _historyTile("GrabFood", "- RM 24.90", "Food", Icons.fastfood),
                _historyTile("Petrol Station", "- RM 55.00", "Transport",
                    Icons.local_gas_station),
                _historyTile("Shopee Purchase", "- RM 129.00", "Shopping",
                    Icons.shopping_bag),
                _historyTile("Salary", "+ RM 2400.00", "Income",
                    Icons.attach_money),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // FILTER CHIP
  // ===============================================================
  Widget _filterChip(String label, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.green.shade800 : Colors.green.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : Colors.green.shade900,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ===============================================================
  // HISTORY TILE
  // ===============================================================
  Widget _historyTile(
      String title, String amount, String category, IconData icon) {
    final isIncome = amount.contains("+");

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.green.shade900, size: 26),
          ),
          const SizedBox(width: 16),

          // Text Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.green.shade900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(category, style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),

          // Amount
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isIncome ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
