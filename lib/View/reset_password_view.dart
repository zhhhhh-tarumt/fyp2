import 'package:flutter/material.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final emailController = TextEditingController();

  bool sent = false;

  void sendReset() {
    setState(() => sent = true);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Reset link has been sent!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Reset Password"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            Text(
              "Forgot Password?",
              style: TextStyle(
                color: green,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Enter your email and we'll send you a password reset link.",
              style: TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 30),

            // EMAIL INPUT
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: sendReset,
              child: const Text("Send Reset Link"),
            ),

            if (sent) ...[
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.check_circle, color: green),
                  const SizedBox(width: 10),
                  const Text("Check your email inbox."),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}
