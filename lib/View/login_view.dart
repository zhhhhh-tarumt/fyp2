import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isLoading = false;

  void doLogin() {
    setState(() => isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => isLoading = false);
      Navigator.pushReplacementNamed(context, "/nav");
    });
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

                        // ==================================================
                        // TOP SPACING → Makes UI move downward
                        // ==================================================
                        const SizedBox(height: 80),

                        // TITLE
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome Back!",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  color: green,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Continue your financial journey.",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green.shade900.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 50),

                        // ==================================================
                        // INPUT FIELDS
                        // ==================================================
                        _inputField(
                          controller: phoneController,
                          hint: "Enter your phone number",
                          icon: Icons.phone_android_outlined,
                        ),

                        const SizedBox(height: 20),

                        _inputField(
                          controller: passwordController,
                          hint: "Enter your password",
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),

                        const SizedBox(height: 15),

                        // RESET PASSWORD
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, "/resetPassword"),
                            child: Text(
                              "Reset Password?",
                              style: TextStyle(
                                color: green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 35),

                        // LOGIN BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : doLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2)
                                : const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // DIVIDER
                        Row(
                          children: [
                            Expanded(
                                child: Container(height: 1, color: Colors.black26)),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text("or"),
                            ),
                            Expanded(
                                child: Container(height: 1, color: Colors.black26)),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // SOCIAL LOGINS
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

                        const SizedBox(height: 40),

                        // SIGN UP
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, "/register"),
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: const TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: "Sign up.",
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

  // ============================================================
  // Reusable Input Box
  // ============================================================
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    final green = Colors.green.shade800;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.green.shade200, width: 1.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
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
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: green,
              ),
              onPressed: () =>
                  setState(() => isPasswordVisible = !isPasswordVisible),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // Social Login Icons
  // ============================================================
  Widget _socialIconGoogle() => _circle(icon: Icons.g_mobiledata, color: Colors.red);
  Widget _socialIconFacebook() => _circle(icon: Icons.facebook, color: Colors.blue);
  Widget _socialIconApple() => _circle(icon: Icons.apple, color: Colors.black);

  Widget _circle({required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black26)),
      child: Icon(icon, size: 32, color: color),
    );
  }
}
