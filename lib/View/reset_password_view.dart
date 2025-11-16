import 'package:flutter/material.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final contactController = TextEditingController();

  bool isEmail(String input) {
    return input.contains("@") && input.contains(".");
  }

  bool isPhone(String input) {
    return RegExp(r'^[0-9]{9,12}$').hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      backgroundColor: Colors.green.shade50,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade50,
        iconTheme: IconThemeData(color: green),
        centerTitle: true,
        title: Text(
          "Reset Password",
          style: TextStyle(color: green, fontWeight: FontWeight.w700),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            children: [
              const SizedBox(height: 70),

              // TITLE
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: green,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enter your email or phone number to receive a reset code.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.green.shade900.withOpacity(0.6),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // INPUT FIELD
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.green.shade200, width: 1.3),
                ),
                child: Row(
                  children: [
                    Icon(Icons.person_outline, color: green),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: contactController,
                        decoration: const InputDecoration(
                          hintText: "Email or Phone Number",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // SEND RESET BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    String input = contactController.text.trim();

                    if (input.isEmpty ||
                        (!isEmail(input) && !isPhone(input))) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                "Please enter a valid email or phone number.")),
                      );
                      return;
                    }

                    Navigator.pushNamed(context, "/pinAuthorize",
                        arguments: isPhone(input) ? "phone" : "gmail");
                  },
                  child: const Text(
                    "Send Reset Code",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 45),

              // DIVIDER
              Row(
                children: [
                  Expanded(
                      child: Container(height: 1, color: Colors.black26)),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("or")),
                  Expanded(
                      child: Container(height: 1, color: Colors.black26)),
                ],
              ),

              const SizedBox(height: 25),

              // BACK TO LOGIN
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, "/login"),
                child: RichText(
                  text: TextSpan(
                    text: "Remember your password? ",
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Login.",
                        style: TextStyle(
                            color: green, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
