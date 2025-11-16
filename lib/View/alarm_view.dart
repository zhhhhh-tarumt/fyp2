import 'package:flutter/material.dart';

class AlarmSettingsView extends StatefulWidget {
  const AlarmSettingsView({super.key});

  @override
  State<AlarmSettingsView> createState() => _AlarmSettingsViewState();
}

class _AlarmSettingsViewState extends State<AlarmSettingsView> {
  bool pushEnabled = true;
  bool soundEnabled = true;
  bool vibrationEnabled = true;

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Alarm Settings"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            "Customize how BudgetMate alerts you.",
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
          ),
          const SizedBox(height: 20),

          // 🔔 Push notification toggle
          switchTile(
            title: "Push Alerts",
            subtitle: "Receive app alerts instantly",
            value: pushEnabled,
            onChanged: (v) => setState(() => pushEnabled = v),
          ),

          switchTile(
            title: "Sound",
            subtitle: "Play alert sound",
            value: soundEnabled,
            onChanged: (v) => setState(() => soundEnabled = v),
          ),

          switchTile(
            title: "Vibration",
            subtitle: "Vibrate on alert",
            value: vibrationEnabled,
            onChanged: (v) => setState(() => vibrationEnabled = v),
          ),
        ],
      ),
    );
  }

  Widget switchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.green,
          )
        ],
      ),
    );
  }
}
