import 'package:flutter/material.dart';
import 'profile_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          sectionTitle("Account", green),

          settingsItem(
            icon: Icons.person,
            title: "Profile",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileView()),
            ),
          ),

          settingsItem(
            icon: Icons.lock_open_rounded,
            title: "Reset Password",
            onTap: () => Navigator.pushNamed(context, "/resetPassword"),
          ),

          settingsItem(
            icon: Icons.password,
            title: "Change PIN",
            onTap: () => Navigator.pushNamed(context, "/pinAuthorize"),
          ),

          const Divider(height: 40),

          sectionTitle("General", green),

          settingsItem(
            icon: Icons.notifications,
            title: "Notifications",
            onTap: () => Navigator.pushNamed(context, "/notifications"),
          ),

          settingsItem(
            icon: Icons.language,
            title: "Language",
            trailing: Text("English", style: TextStyle(color: Colors.grey.shade600)),
            onTap: () => Navigator.pushNamed(context, "/language"),
          ),

          settingsItem(
            icon: Icons.dark_mode_outlined,
            title: "Appearance",
            onTap: () => Navigator.pushNamed(context, "/appearance"),
          ),

          const Divider(height: 40),

          sectionTitle("Help & Support", green),

          settingsItem(
            icon: Icons.help_center,
            title: "FAQ",
            onTap: () => Navigator.pushNamed(context, "/faq"),
          ),

          settingsItem(
            icon: Icons.support_agent,
            title: "Contact Support",
            onTap: () => Navigator.pushNamed(context, "/support"),
          ),

          settingsItem(
            icon: Icons.info_outline,
            title: "About App",
            onTap: () => Navigator.pushNamed(context, "/about"),
          ),

          const Divider(height: 40),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () => Navigator.pushReplacementNamed(context, "/login"),
              child: const Text("Logout", style: TextStyle(color: Colors.white, fontSize: 17)),
            ),
          )
        ],
      ),
    );
  }

  Widget sectionTitle(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(text, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget settingsItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
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
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
