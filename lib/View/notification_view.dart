import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  bool pushNotif = true;
  bool expenseReminder = false;
  bool budgetAlert = true;
  bool dailySummary = true;
  bool monthlyReport = false;

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      appBar: AppBar(title: const Text("Notifications"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          sectionTitle("General Notifications", green),
          switchTile("Push Notifications", Icons.notifications_active, pushNotif, (v) => setState(() => pushNotif = v)),
          switchTile("Expense Reminders", Icons.alarm, expenseReminder, (v) => setState(() => expenseReminder = v)),

          const Divider(height: 40),

          sectionTitle("Financial Alerts", green),
          switchTile("Budget Alerts", Icons.wallet, budgetAlert, (v) => setState(() => budgetAlert = v)),
          switchTile("Daily Summary", Icons.today, dailySummary, (v) => setState(() => dailySummary = v)),
          switchTile("Monthly Report", Icons.calendar_month, monthlyReport, (v) => setState(() => monthlyReport = v)),
        ],
      ),
    );
  }

  Widget sectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(title, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget switchTile(String title, IconData icon, bool value, Function(bool) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.green.shade700),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green.shade900)),
        trailing: Switch(value: value, activeColor: Colors.green, onChanged: onChanged),
      ),
    );
  }
}
