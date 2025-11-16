import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    final notifications = [
      {
        "title": "Payment Successful",
        "msg": "Your RM 24.90 food payment has been completed.",
        "time": "2h ago",
        "icon": Icons.check_circle
      },
      {
        "title": "BNPL Reminder",
        "msg": "Your installment due tomorrow. Please make payment.",
        "time": "6h ago",
        "icon": Icons.notifications_active
      },
      {
        "title": "Cashback Earned",
        "msg": "You earned RM2 cashback from TGV Cinema.",
        "time": "1d ago",
        "icon": Icons.card_giftcard
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: notifications.length,
        itemBuilder: (context, i) {
          final data = notifications[i];

          return Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.green.shade100),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    data["icon"] as IconData,
                    color: Colors.green.shade900,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data["title"].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: green,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data["msg"].toString(),
                        style:
                            TextStyle(color: Colors.grey.shade700, fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        data["time"].toString(),
                        style:
                            TextStyle(color: Colors.grey.shade500, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
