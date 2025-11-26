import 'package:flutter/material.dart';

class BNPLDetailView extends StatelessWidget {
  final String title;
  final String provider;
  final String total;
  final int paid;
  final int totalPayments;
  final DateTime dueDate;

  const BNPLDetailView({
    super.key,
    required this.title,
    required this.provider,
    required this.total,
    required this.paid,
    required this.totalPayments,
    required this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;
    final greenMid = Colors.green.shade700;
    final progress = paid / totalPayments;

    final daysLeft = dueDate.difference(DateTime.now()).inDays;

    return Scaffold(
      appBar: AppBar(title: const Text("Installment Details")),

      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 26, fontWeight: FontWeight.w800, color: green)),
            const SizedBox(height: 4),
            Text(provider, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            // Animated progress bar
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: progress),
              duration: const Duration(milliseconds: 900),
              builder: (context, value, child) => Stack(
                children: [
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  Container(
                    height: 12,
                    width: MediaQuery.of(context).size.width * value,
                    decoration: BoxDecoration(
                      color: greenMid,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Text("Paid $paid of $totalPayments installments",
                style: TextStyle(fontWeight: FontWeight.bold, color: green)),

            const SizedBox(height: 16),

            Text("Total Amount: $total",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: green)),

            const SizedBox(height: 16),

            Text(
              "Next payment due in $daysLeft days",
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
            ),

            const SizedBox(height: 30),

            Text("Installment Breakdown",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: green)),

            const SizedBox(height: 14),

            Expanded(
              child: ListView.builder(
                itemCount: totalPayments,
                itemBuilder: (context, index) {
                  final isPaid = index < paid;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isPaid ? Colors.green.shade50 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color:
                              isPaid ? Colors.green.shade300 : Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Installment ${index + 1}"),
                        Icon(
                          isPaid ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: isPaid ? Colors.green : Colors.grey,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // PAY NEXT INSTALLMENT BUTTON
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenMid,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Payment processing... (Demo)"),
                    ),
                  );
                },
                child: const Text(
                  "Pay Next Installment",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
