import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
      ),
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // PROFILE PHOTO
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.green.shade100,
              child: const Icon(Icons.person, size: 60, color: Colors.white),
            ),

            const SizedBox(height: 20),

            Text(
              "Your Profile",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),

            const SizedBox(height: 20),

            // INFO CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text("Email"),
                    subtitle: Text("user@example.com"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.phone_android),
                    title: Text("Phone Number"),
                    subtitle: Text("+6012-3456789"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Address"),
                    subtitle: Text("Your saved address here"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/resetPassword");
                },
                child: const Text("Change Password"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
