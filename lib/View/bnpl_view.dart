import 'package:flutter/material.dart';
import 'bnpl_detail_view.dart';
import 'bnpl_history_view.dart';

class BNPLView extends StatelessWidget {
  const BNPLView({super.key});

  @override
  Widget build(BuildContext context) {
    final greenDark = Colors.green.shade900;

    final bnplItems = [
      {
        "title": "Macbook Air 2024",
        "provider": "BudgetMate BNPL",
        "total": "RM 4,800",
        "paid": 2,
        "totalPayments": 6,
        "dueDate": DateTime.now().add(const Duration(days: 12)),
      },
      {
        "title": "Nike Air Max",
        "provider": "BudgetMate BNPL",
        "total": "RM 450",
        "paid": 3,
        "totalPayments": 4,
        "dueDate": DateTime.now().add(const Duration(days: 5)),
      },
      {
        "title": "Study Desk",
        "provider": "BudgetMate BNPL",
        "total": "RM 299",
        "paid": 1,
        "totalPayments": 3,
        "dueDate": DateTime.now().add(const Duration(days: 18)),
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("BNPL Tracker"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BNPLHistoryView()),
            ),
          )
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            "Active Installment Plans",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: greenDark,
            ),
          ),

          const SizedBox(height: 20),

          ...bnplItems.map((item) => _bnplCard(context, item)).toList(),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ==========================================================
  // PREMIUM BNPL CARD
  // ==========================================================
  Widget _bnplCard(BuildContext context, Map item) {
    final greenDark = Colors.green.shade900;
    final greenMid = Colors.green.shade700;

    final paid = item["paid"];
    final totalPayments = item["totalPayments"];
    final progress = paid / totalPayments;

    final dueDate = item["dueDate"];
    final daysLeft = dueDate.difference(DateTime.now()).inDays;

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item["title"],
              style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: greenDark)),

          const SizedBox(height: 4),

          Text(item["provider"],
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),

          const SizedBox(height: 12),

          // Animated progress bar
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: progress),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOut,
            builder: (context, value, child) => Stack(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Container(
                  height: 10,
                  width: 200 * value,
                  decoration: BoxDecoration(
                    color: greenMid,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Paid: $paid / $totalPayments",
                  style: TextStyle(fontWeight: FontWeight.w600, color: greenDark)),
              Text(item["total"],
                  style: TextStyle(fontWeight: FontWeight.bold, color: greenMid)),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            "Next payment in $daysLeft days",
            style: TextStyle(color: Colors.grey.shade700),
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: greenMid,
              minimumSize: const Size(double.infinity, 46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BNPLDetailView(
                    title: item["title"],
                    provider: item["provider"],
                    total: item["total"],
                    paid: item["paid"],
                    totalPayments: item["totalPayments"],
                    dueDate: item["dueDate"],
                  ),
                ),
              );
            },
            child: const Text("View Installment Details",
                style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
