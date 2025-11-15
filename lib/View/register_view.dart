import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final contact = TextEditingController();

  bool isPhone(String input) {
    return RegExp(r'^[0-9]{9,12}$').hasMatch(input);
  }

  bool isEmail(String input) {
    return input.contains("@") && input.contains(".");
  }

  @override
  Widget build(BuildContext context) {
    final greenDark = Colors.green.shade900;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create an Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),

            Text(
              "Register with Gmail or Phone Number",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: greenDark,
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: contact,
              decoration: const InputDecoration(
                labelText: "Email or Phone Number",
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                final input = contact.text.trim();

                if (input.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text("Please enter email or phone number.")),
                  );
                  return;
                }

                String method = "";
                if (isPhone(input)) {
                  method = "phone";
                } else if (isEmail(input)) {
                  method = "gmail";
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Invalid email or phone number.")),
                  );
                  return;
                }

                Navigator.pushNamed(
                  context,
                  "/pinAuthorize",
                  arguments: method,
                );
              },
              child: const Text("Continue"),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey.shade300)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("OR"),
                ),
                Expanded(child: Divider(color: Colors.grey.shade300)),
              ],
            ),

            const SizedBox(height: 18),

            OutlinedButton.icon(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, "/login"),
              icon: const Icon(Icons.apple, size: 26, color: Colors.black),
              label: const Text("Continue with Apple"),
            ),

            const SizedBox(height: 10),

            OutlinedButton.icon(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, "/login"),
              icon: const Icon(Icons.facebook, color: Colors.blue),
              label: const Text("Continue with Facebook"),
            ),
          ],
        ),
      ),
    );
  }
}
