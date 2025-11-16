import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final nameCtrl = TextEditingController(text: "BudgetMate User");
  final emailCtrl = TextEditingController(text: "user@example.com");
  final phoneCtrl = TextEditingController(text: "+60 12-345 6789");

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Avatar & Name
            CircleAvatar(
              radius: 46,
              backgroundColor: Colors.green.shade100,
              child: Icon(Icons.person, size: 52, color: Colors.green.shade700),
            ),

            const SizedBox(height: 16),

            Text(
              nameCtrl.text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: green,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              emailCtrl.text,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 24),

            // Card with editable fields
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.shade100),
              ),
              child: Column(
                children: [
                  headerRow("Personal Details", isEditing, green),
                  const SizedBox(height: 12),

                  buildField(
                    label: "Full Name",
                    controller: nameCtrl,
                    icon: Icons.person_outline,
                    enabled: isEditing,
                  ),
                  const SizedBox(height: 12),

                  buildField(
                    label: "Email",
                    controller: emailCtrl,
                    icon: Icons.email_outlined,
                    enabled: isEditing,
                  ),
                  const SizedBox(height: 12),

                  buildField(
                    label: "Phone Number",
                    controller: phoneCtrl,
                    icon: Icons.phone_android_outlined,
                    enabled: isEditing,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Save / Edit Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  if (isEditing) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Profile updated (sample only, no backend)."),
                      ),
                    );
                  }
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                child: Text(
                  isEditing ? "Save Changes" : "Edit Profile",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextButton(
              onPressed: () => Navigator.pushNamed(context, "/resetPassword"),
              child: Text(
                "Change Password",
                style: TextStyle(color: green, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerRow(String title, bool isEditing, Color green) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: green,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isEditing
                ? Colors.orange.shade50
                : Colors.green.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isEditing
                  ? Colors.orange.shade300
                  : Colors.green.shade200,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isEditing ? Icons.edit_note : Icons.visibility_outlined,
                size: 16,
                color: isEditing ? Colors.orange.shade700 : green,
              ),
              const SizedBox(width: 4),
              Text(
                isEditing ? "Editing" : "View Only",
                style: TextStyle(
                  fontSize: 12,
                  color: isEditing ? Colors.orange.shade700 : green,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool enabled = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.green.shade800,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.green.shade700),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.green.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.green.shade200),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.green.shade100),
            ),
          ),
        ),
      ],
    );
  }
}
