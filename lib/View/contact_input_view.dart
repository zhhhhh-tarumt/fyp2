import 'package:flutter/material.dart';

class ContactInputView extends StatelessWidget {
  final String method; // "gmail" or "phone"
  final contact = TextEditingController();

  ContactInputView({super.key, required this.method});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(method == "gmail"
            ? "Register with Google"
            : "Register with Phone Number"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              method == "gmail"
                  ? "Enter your Google Email"
                  : "Enter your Phone Number",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: contact,
              keyboardType:
                  method == "phone" ? TextInputType.phone : TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: method == "gmail" ? "Google Email" : "Phone Number",
                border: const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (contact.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a valid contact")),
                  );
                  return;
                }

                Navigator.pushNamed(
                  context,
                  "/pinAuthorize",
                  arguments: method, // pass gmail or phone
                );
              },
              child: const Text("Send PIN"),
            ),
          ],
        ),
      ),
    );
  }
}
