import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // Profile Picture
            const CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage("assets/profile.jpg"),
            ),

            const SizedBox(height: 15),

            // Username
            const Text(
              "User Name",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            // Email
            const Text(
              "user@example.com",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 25),

            // Profile Options List
            _profileOption(
              icon: Icons.person,
              title: "Edit Profile",
              onTap: () {},
            ),

            _profileOption(
              icon: Icons.lock,
              title: "Change Password",
              onTap: () {},
            ),

            _profileOption(
              icon: Icons.notifications,
              title: "Notification Settings",
              onTap: () {},
            ),

            _profileOption(
              icon: Icons.language,
              title: "Language",
              onTap: () {},
            ),

            _profileOption(
              icon: Icons.security,
              title: "Privacy & Security",
              onTap: () {},
            ),

            _profileOption(
              icon: Icons.history,
              title: "Transaction History",
              onTap: () {},
            ),

            const SizedBox(height: 30),

            // Logout Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Logout",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, size: 28, color: Colors.blueAccent),
          title: Text(title, style: const TextStyle(fontSize: 16)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
        const Divider(height: 1),
      ],
    );
  }
}
