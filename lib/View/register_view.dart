import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  bool isPhoneValid(String input) {
    return RegExp(r'^[0-9]{9,12}$').hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      backgroundColor: Colors.green.shade50,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 90),   // SHIFT CONTENT DOWN

                        // TITLE
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Welcome!",
                            style: TextStyle(
                              fontSize: 32,
                              color: green,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Start your journey today.",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.green.shade900.withOpacity(0.6),
                            ),
                          ),
                        ),

                        const SizedBox(height: 55),

                        // PHONE INPUT
                        _roundedInput(
                          controller: phoneController,
                          hint: "Enter your phone number",
                          icon: Icons.phone_android_outlined,
                        ),

                        const SizedBox(height: 20),

                        // PASSWORD INPUT
                        _roundedInput(
                          controller: passwordController,
                          hint: "Enter your password",
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),

                        const SizedBox(height: 40),

                        // CREATE ACCOUNT BUTTON (WHITE TEXT)
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              String input = phoneController.text.trim();

                              if (!isPhoneValid(input)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Please enter a valid phone number."),
                                  ),
                                );
                                return;
                              }

                              Navigator.pushNamed(
                                context,
                                "/pinAuthorize",
                                arguments: "phone",
                              );
                            },
                            child: const Text(
                              "Create Your Account",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white, // FIXED
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // DIVIDER
                        Row(
                          children: [
                            Expanded(
                                child: Container(height: 1, color: Colors.black26)),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text("or"),
                            ),
                            Expanded(
                                child: Container(height: 1, color: Colors.black26)),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // SOCIAL ICONS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialIconGoogle(),
                            const SizedBox(width: 22),
                            _socialIconFacebook(),
                            const SizedBox(width: 22),
                            _socialIconApple(),
                          ],
                        ),

                        const SizedBox(height: 45),

                        // SIGN IN LINK
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushReplacementNamed(context, "/login"),
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: const TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: "Sign in.",
                                  style: TextStyle(
                                    color: green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // -----------------------------------------------------------
  // BEAUTIFUL ROUNDED INPUT FIELD
  // -----------------------------------------------------------
  Widget _roundedInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    final green = Colors.green.shade800;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.green.shade200, width: 1.3),
      ),
      child: Row(
        children: [
          Icon(icon, color: green),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword && !isPasswordVisible,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
            ),
          ),
          if (isPassword)
            IconButton(
              icon: Icon(
                isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: green,
              ),
              onPressed: () =>
                  setState(() => isPasswordVisible = !isPasswordVisible),
            ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------
  // SOCIAL ICON BUTTONS
  // -----------------------------------------------------------
  Widget _socialIconGoogle() => _circleIcon(Icons.g_mobiledata, Colors.red);
  Widget _socialIconFacebook() => _circleIcon(Icons.facebook, Colors.blue);
  Widget _socialIconApple() => _circleIcon(Icons.apple, Colors.black);

  Widget _circleIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black26),
      ),
      child: Icon(icon, size: 32, color: color),
    );
  }
}
