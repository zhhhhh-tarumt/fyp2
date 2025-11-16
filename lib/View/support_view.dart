import 'package:flutter/material.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Support"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // HEADER
            Column(
              children: [
                Image.asset("assets/images/kangaroo.png", height: 90),
                const SizedBox(height: 10),
                Text(
                  "We're Here to Help!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Reach out anytime and our team will assist you.",
                  style: TextStyle(color: Colors.grey.shade700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
              ],
            ),

            // OPTIONS
            _supportTile(
              context,
              icon: Icons.email_outlined,
              title: "Email Support",
              subtitle: "Get a reply within 24 hours",
              route: "/emailSupport",
            ),

            _supportTile(
              context,
              icon: Icons.chat_bubble_outline,
              title: "Live Chat",
              subtitle: "Talk with our support team",
              route: "/liveChat",
            ),

            _supportTile(
              context,
              icon: Icons.help_outline,
              title: "FAQ",
              subtitle: "Frequently asked questions",
              route: "/faq",
            ),

            _supportTile(
              context,
              icon: Icons.report_problem_outlined,
              title: "Report a Problem",
              subtitle: "Tell us if something is not working",
              route: "/reportProblem",
            ),

            _supportTile(
              context,
              icon: Icons.feedback_outlined,
              title: "App Feedback",
              subtitle: "Help us improve BudgetMate",
              route: "/feedback",
            ),

            const SizedBox(height: 30),

            Text(
              "BudgetMate Support Team",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Available Daily • 9:00 AM – 10:00 PM",
              style: TextStyle(color: Colors.grey.shade500),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // REUSABLE TILE
  Widget _supportTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String route,
  }) {
    final green = Colors.green.shade900;

    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.green.shade100),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: green, size: 26),
            ),
            const SizedBox(width: 15),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: green,
                      )),
                  const SizedBox(height: 3),
                  Text(subtitle, style: TextStyle(color: Colors.grey.shade700)),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios, size: 18),
          ],
        ),
      ),
    );
  }
}
