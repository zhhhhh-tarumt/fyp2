import 'package:flutter/material.dart';

class CashFlowView extends StatelessWidget {
  const CashFlowView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Cash Flow"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // ==========================================================
              // DONUT CHART PLACEHOLDER (MODERN STYLE)
              // ==========================================================
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    // Donut Chart Placeholder
                    Container(
                      height: 220,
                      width: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.green.shade300,
                            Colors.green.shade600,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 12,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "RM 70.00",
                              style: TextStyle(
                                color: green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // CATEGORY LEGEND
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 18,
                      runSpacing: 10,
                      children: [
                        _legend("Food", Colors.green.shade500),
                        _legend("Transport", Colors.orange.shade400),
                        _legend("Shopping", Colors.blue.shade400),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ==========================================================
              // SECTION HEADER
              // ==========================================================
              Row(
                children: [
                  Icon(Icons.calendar_today, color: green, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "Today",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: green,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ==========================================================
              // TRANSACTION LIST
              // ==========================================================
              _transactionCard(
                icon: Icons.fastfood_rounded,
                title: "Food & Drink",
                subtitle: "Lunch • 12:40 PM",
                amount: "-RM 21.00",
                color: Colors.green.shade500,
              ),
              _transactionCard(
                icon: Icons.directions_bus_rounded,
                title: "Transport",
                subtitle: "Bus Ride • 9:30 AM",
                amount: "-RM 9.00",
                color: Colors.orange.shade400,
              ),
              _transactionCard(
                icon: Icons.shopping_bag_rounded,
                title: "Shopping",
                subtitle: "Shopee • 8:05 AM",
                amount: "-RM 40.00",
                color: Colors.blue.shade400,
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // LEGEND WIDGET
  // ==========================================================
  Widget _legend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }

  // ==========================================================
  // TRANSACTION CARD
  // ==========================================================
  Widget _transactionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28, color: color),
          ),

          const SizedBox(width: 14),

          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style:
                      TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            amount,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
