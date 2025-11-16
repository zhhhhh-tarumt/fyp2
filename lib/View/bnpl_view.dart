import 'package:flutter/material.dart';

class BNPLView extends StatelessWidget {
  const BNPLView({super.key});

  @override
  Widget build(BuildContext context) {
    final greenDark = Colors.green.shade900;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("BNPL Tracker"),
        centerTitle: true,
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

          _bnplCard(
            title: "Macbook Air 2024",
            provider: "BudgetMate BNPL",
            total: "RM 4,800",
            paid: 2,
            totalPayments: 6,
          ),

          _bnplCard(
            title: "Nike Air Max",
            provider: "BudgetMate BNPL",
            total: "RM 450",
            paid: 3,
            totalPayments: 4,
          ),

          _bnplCard(
            title: "Study Desk",
            provider: "BudgetMate BNPL",
            total: "RM 299",
            paid: 1,
            totalPayments: 3,
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ==========================================================
  // PREMIUM BNPL CARD
  // ==========================================================
  Widget _bnplCard({
    required String title,
    required String provider,
    required String total,
    required int paid,
    required int totalPayments,
  }) {
    final greenDark = Colors.green.shade900;
    final greenMid = Colors.green.shade700;

    final progress = paid / totalPayments;

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
          // ITEM NAME
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: greenDark,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            provider,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 14),

          // PROGRESS BAR
          Stack(
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
                width: 200 * progress,
                decoration: BoxDecoration(
                  color: greenMid,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Paid: $paid / $totalPayments",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: greenDark,
                ),
              ),
              Text(
                total,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: greenMid,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // VIEW DETAILS BUTTON
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: greenMid,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "View Installment Details",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
