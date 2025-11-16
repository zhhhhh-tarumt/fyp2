import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;
    final darkGreen = Colors.green.shade900;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [

          // ========================================================
          // TOP WALLET SECTION
          // ========================================================
          Container(
            padding: const EdgeInsets.fromLTRB(20, 55, 20, 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade700,
                  Colors.green.shade600,
                  Colors.green.shade500,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Wallet Balance",
                    style: TextStyle(color: Colors.white70, fontSize: 15)),
                const SizedBox(height: 6),

                Text(
                  "RM 1,000.00",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
<<<<<<< Updated upstream
                    quickAction(Icons.add, "Add", "/reloadMoney", context),
                    quickAction(Icons.swap_horiz, "Transfer", "/transferContact", context),
                    quickAction(Icons.qr_code, "Scan", "/merchantScan", context),
=======
                    _walletButton(
                      icon: Icons.add_circle_outline,
                      label: "Reload",
                      color: Colors.white,
                      onTap: () => Navigator.pushNamed(context, "/deposit"),
                    ),
                    const SizedBox(width: 10),
                    _walletButton(
                      icon: Icons.receipt_long,
                      label: "History",
                      color: Colors.white,
                      onTap: () => Navigator.pushNamed(context, "/history"),
                    ),
>>>>>>> Stashed changes
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // ========================================================
          // QUICK ACTIONS
          // ========================================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _actionTop(context, Icons.swap_horiz, "Transfer", "/transfer"),
                  _actionTop(context, Icons.call_received, "Receive", "/receive"),
                  _actionTop(context, Icons.qr_code_scanner, "Scan", "/merchantScan"),
                  _actionTop(context, Icons.notifications_none, "Notify", "/notifications"),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ========================================================
          // SERVICES GRID
          // ========================================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Services",
              style: TextStyle(
                  color: darkGreen, fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 0.85,
              children: [
                _serviceItem(context, Icons.edit_note, "Expense\nInput", "/addExpense"),
                _serviceItem(context, Icons.mic, "Voice\nInput", "/voiceInput"),
                _serviceItem(context, Icons.analytics, "Analytics", "/analysis"),
                _serviceItem(context, Icons.lightbulb_outline, "AI Insight", "/aiInsight"),
                _serviceItem(context, Icons.account_balance_wallet, "BNPL", "/bnpl"),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ========================================================
          // REWARDS SECTION
          // ========================================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "My Rewards",
              style: TextStyle(
                  color: darkGreen, fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 10),

<<<<<<< Updated upstream
          shortcutCard(
            context,
            title: "Transfer Money",
            icon: Icons.swap_horiz,
            route: "/transferContact",
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
=======
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4))
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.local_offer, color: Colors.green),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("RM 2 cashback earned",
                            style: TextStyle(
                                color: darkGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        const SizedBox(height: 4),
                        Text("Watsons TGV Cinema Purchase",
                            style: TextStyle(color: Colors.grey.shade600)),
                      ],
                    ),
                  )
                ],
              ),
            ),
>>>>>>> Stashed changes
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  // WALLET BUTTON
  // ----------------------------------------------------
  Widget _walletButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------
  // QUICK ACTIONS
  // ----------------------------------------------------
  Widget _actionTop(
      BuildContext context, IconData icon, String title, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.shade50,
            ),
            child: Icon(icon, color: Colors.green.shade800, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: Colors.green.shade900,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  // SERVICE ITEM (WITH LINK)
  // ----------------------------------------------------
  Widget _serviceItem(
      BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.green.shade800, size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green.shade900,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
