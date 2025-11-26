import 'package:flutter/material.dart';
import '../Controller/register_controller.dart'; // 1. Import Controller

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final phoneController = TextEditingController();
  final emailController = TextEditingController(); // Added Email field
  final usernameController = TextEditingController(); // Added Username field
  final passwordController = TextEditingController();
  
  bool isPasswordVisible = false;
  bool isLoading = false; // To show loading indicator

  final RegisterController _controller = RegisterController(); // 2. Instantiate Controller

  bool isPhoneValid(String input) {
    return RegExp(r'^[0-9]{9,12}$').hasMatch(input);
  }

  // 3. Create Registration Function
  void handleRegistration() async {
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    // Basic Validation
    if (phone.isEmpty || email.isEmpty || username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")),
      );
      return;
    }

    if (!isPhoneValid(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid phone number.")),
      );
      return;
    }

    setState(() => isLoading = true);

    // Call Controller
    String result = await _controller.registerUser(username, email, phone, password);

    setState(() => isLoading = false);

    if (result == "Success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account Created Successfully!")),
      );
      
      // Navigate to PIN setup or Login
      Navigator.pushNamed(
        context,
        "/pinAuthorize",
        arguments: "phone", // You might want to pass userId here later
      );
    } else {
      // Show Error from Controller (e.g., "User already exists")
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result), backgroundColor: Colors.red),
      );
    }
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
                        const SizedBox(height: 60), // Reduced top spacing slightly

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

                        const SizedBox(height: 40),

                        // USERNAME INPUT (Added)
                        _roundedInput(
                          controller: usernameController,
                          hint: "Full Name",
                          icon: Icons.person_outline,
                        ),

                        const SizedBox(height: 20),

                        // EMAIL INPUT (Added - Required for Firebase Auth)
                        _roundedInput(
                          controller: emailController,
                          hint: "Email Address",
                          icon: Icons.email_outlined,
                        ),

                        const SizedBox(height: 20),

                        // PHONE INPUT
                        _roundedInput(
                          controller: phoneController,
                          hint: "Phone Number",
                          icon: Icons.phone_android_outlined,
                        ),

                        const SizedBox(height: 20),

                        // PASSWORD INPUT
                        _roundedInput(
                          controller: passwordController,
                          hint: "Password",
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),

                        const SizedBox(height: 40),

                        // CREATE ACCOUNT BUTTON
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
                            onPressed: isLoading ? null : handleRegistration, // Disable if loading
                            child: isLoading 
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  "Create Your Account",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
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
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text("or"),
                            ),
                            Expanded(
                                child: Container(height: 1, color: Colors.black26)),
                          ],
                        ),

                        const SizedBox(height: 20),

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

                        const SizedBox(height: 30),

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

                        const SizedBox(height: 30),
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