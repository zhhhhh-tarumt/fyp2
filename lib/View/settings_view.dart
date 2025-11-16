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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [

          // -----------------------------
          // ACCOUNT SECTION
          // -----------------------------
          sectionTitle("Account", green),
          settingsCard(
            children: [
              settingsItem(
                icon: Icons.person_outline,
                title: "Profile",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileView()),
                ),
              ),
              divider(),
              settingsItem(
                icon: Icons.lock_reset,
                title: "Reset Password",
                onTap: () => Navigator.pushNamed(context, "/resetPassword"),
              ),
              divider(),
              settingsItem(
                icon: Icons.pin_outlined,
                title: "Change PIN",
                onTap: () => Navigator.pushNamed(context, "/pinAuthorize"),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // -----------------------------
          // GENERAL SECTION
          // -----------------------------
          sectionTitle("General", green),
          settingsCard(
            children: [
              // 🔔 CHANGED HERE → Alarm Page
              settingsItem(
                icon: Icons.notifications_active_outlined,
                title: "Alarm Settings",
                onTap: () => Navigator.pushNamed(context, "/alarm"),
              ),
              divider(),
              settingsItem(
                icon: Icons.language_outlined,
                title: "Language",
                trailing: Text(
                  "English",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                onTap: () => Navigator.pushNamed(context, "/language"),
              ),
              divider(),
              settingsItem(
                icon: Icons.dark_mode_outlined,
                title: "Appearance",
                onTap: () => Navigator.pushNamed(context, "/appearance"),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // -----------------------------
          // HELP & SUPPORT SECTION
          // -----------------------------
          sectionTitle("Help & Support", green),
          settingsCard(
            children: [
              settingsItem(
                icon: Icons.help_outline,
                title: "FAQ",
                onTap: () => Navigator.pushNamed(context, "/faq"),
              ),
              divider(),
              settingsItem(
                icon: Icons.support_agent_outlined,
                title: "Contact Support",
                onTap: () => Navigator.pushNamed(context, "/support"),
              ),
              divider(),
              settingsItem(
                icon: Icons.info_outline,
                title: "About App",
                onTap: () => Navigator.pushNamed(context, "/about"),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // -----------------------------
          // LOGOUT BUTTON
          // -----------------------------
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
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, "/login"),
              child: const Text(
                "Logout",
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // -----------------------------
  // SECTION TITLE
  // -----------------------------
  Widget sectionTitle(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 5),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 19,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  // -----------------------------
  // CARD WRAPPER
  // -----------------------------
  Widget settingsCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade100),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 3),
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Column(children: children),
    );
  }

  // -----------------------------
  // LIST ITEM
  // -----------------------------
  Widget settingsItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 26, color: Colors.green.shade800),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.green.shade900,
          fontSize: 16,
        ),
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 17),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
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
