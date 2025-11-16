import 'package:flutter/material.dart';

class AppearanceView extends StatefulWidget {
  const AppearanceView({super.key});

  @override
  State<AppearanceView> createState() => _AppearanceViewState();
}

class _AppearanceViewState extends State<AppearanceView> {
  String themeMode = "light"; // "light", "dark", "system"

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appearance"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Customize how BudgetMate looks on your device.",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.shade100),
              ),
              child: Column(
                children: [
                  modeTile("Light Mode", "light", Icons.wb_sunny_outlined, green),
                  divider(),
                  modeTile("Dark Mode", "dark", Icons.dark_mode_outlined, green),
                  divider(),
                  modeTile("Follow System", "system", Icons.phone_android, green),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Small preview card
            Text(
              "Preview",
              style: TextStyle(
                color: green,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: themeMode == "dark"
                      ? [Colors.grey.shade900, Colors.grey.shade800]
                      : [Colors.white, Colors.green.shade50],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.shade100),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: themeMode == "dark"
                        ? Colors.white
                        : Colors.green.shade800,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Balance",
                        style: TextStyle(
                          color: themeMode == "dark"
                              ? Colors.white70
                              : Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "RM 2,410.50",
                        style: TextStyle(
                          color: themeMode == "dark"
                              ? Colors.white
                              : Colors.green.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget modeTile(String title, String value, IconData icon, Color green) {
    final bool selected = themeMode == value;
    return ListTile(
      onTap: () {
        setState(() => themeMode = value);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "Theme set to $title (demo only, not connected to real theme).")),
        );
      },
      leading: Icon(icon, color: Colors.green.shade800),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.green.shade900,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: selected
          ? Icon(Icons.check_circle, color: green)
          : Icon(Icons.radio_button_unchecked, color: Colors.grey.shade500),
    );
  }

  Widget divider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.green.shade100,
      indent: 16,
      endIndent: 16,
    );
  }
}
