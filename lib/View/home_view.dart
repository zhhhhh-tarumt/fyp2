import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),

          // -------------------------------------------------------
          // TOP CARD → Wallet Balance & Quick Buttons
          // -------------------------------------------------------
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.shade700,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.green.shade200.withOpacity(0.5),
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Balance",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 5),
                const Text(
                  "RM 2,410.50",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    quickAction(Icons.add, "Add", "/addExpense", context),
                    quickAction(Icons.swap_horiz, "Transfer", "/transfer", context),
                    quickAction(Icons.qr_code, "Scan", "/merchantScan", context),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // -------------------------------------------------------
          // Shortcut Menu Section
          // -------------------------------------------------------
          sectionTitle("Quick Shortcuts", green),
          const SizedBox(height: 10),

          shortcutCard(
            context,
            title: "Add Expense",
            icon: Icons.add_circle,
            route: "/addExpense",
          ),

          shortcutCard(
            context,
            title: "Voice Expense Input",
            icon: Icons.mic,
            route: "/voiceInput",
          ),

          shortcutCard(
            context,
            title: "Quick Expense Input",
            icon: Icons.add_card,
            route: "/quickExpense",
          ),

          const SizedBox(height: 20),

          // -------------------------------------------------------
          // Transfer Section
          // -------------------------------------------------------
          sectionTitle("Money Transfer", green),
          const SizedBox(height: 10),

          shortcutCard(
            context,
            title: "Transfer Money",
            icon: Icons.swap_horiz,
            route: "/transfer",
          ),
          shortcutCard(
            context,
            title: "Receive Money",
            icon: Icons.qr_code,
            route: "/receive",
          ),
          shortcutCard(
            context,
            title: "Merchant Scan",
            icon: Icons.qr_code_scanner,
            route: "/merchantScan",
          ),

          const SizedBox(height: 20),

          // -------------------------------------------------------
          // Team Module Section
          // -------------------------------------------------------
          sectionTitle("Insights & Tools", green),
          const SizedBox(height: 10),

          shortcutCard(
            context,
            title: "Analytics Dashboard",
            icon: Icons.analytics,
            route: "/analysis",
          ),

          shortcutCard(
            context,
            title: "AI Financial Insights",
            icon: Icons.lightbulb,
            route: "/aiInsight",
          ),

          shortcutCard(
            context,
            title: "BNPL Tracking",
            icon: Icons.account_balance_wallet,
            route: "/bnpl",
          ),

          shortcutCard(
            context,
            title: "Make Payment",
            icon: Icons.payments,
            route: "/payment",
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // -------------------------------------------------------
  // HEADER QUICK ACTION BUTTON
  // -------------------------------------------------------
  Widget quickAction(IconData icon, String label, String route, BuildContext ctx) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(ctx, route),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Icon(icon, size: 32, color: Colors.green.shade700),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.green.shade900)),
        ],
      ),
    );
  }

  // -------------------------------------------------------
  // SECTION TITLE
  // -------------------------------------------------------
  Widget sectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }

  // -------------------------------------------------------
  // SHORTCUT MENU CARD
  // -------------------------------------------------------
  Widget shortcutCard(BuildContext context,
      {required String title, required IconData icon, required String route}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: ListTile(
        leading: Icon(icon, size: 30, color: Colors.green.shade700),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.green.shade900,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
