import 'package:flutter/material.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final nameCtrl = TextEditingController(text: "BudgetMate User");
  final emailCtrl = TextEditingController(text: "user@example.com");
  final phoneCtrl = TextEditingController(text: "+6012-3456789");
  final addressCtrl = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // PROFILE PHOTO
            Center(
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.green.shade100,
                child: const Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),

            _inputField("Full Name", nameCtrl),
            const SizedBox(height: 15),

            _inputField("Email Address", emailCtrl),
            const SizedBox(height: 15),

            _inputField("Phone Number", phoneCtrl),
            const SizedBox(height: 15),

            _inputField("Address", addressCtrl, maxLines: 2),
            const SizedBox(height: 25),

            // SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Profile updated successfully!"),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text("Save Changes"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.green.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
