import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool isPasswordVisible = false;

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
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -----------------------------------
                // TITLE SECTION
                // -----------------------------------
                const SizedBox(height: 30),

                Text(
                  "Welcome Back 👋",
                  style: TextStyle(
                    color: green,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Login to continue managing your finances.",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 35),

                // -----------------------------------
                // EMAIL INPUT
                // -----------------------------------
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.green.shade700),
                      prefixIcon: Icon(Icons.email, color: green),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // -----------------------------------
                // PASSWORD INPUT
                // -----------------------------------
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.green.shade700),
                      prefixIcon: Icon(Icons.lock, color: green),

                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.green.shade700,
                        ),
                        onPressed: () =>
                            setState(() => isPasswordVisible = !isPasswordVisible),
                      ),

                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, "/resetPassword"),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: green),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // -----------------------------------
                // LOGIN BUTTON
                // -----------------------------------
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : doLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2)
                        : const Text(
                            "Login",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                ),

                const SizedBox(height: 25),

                // -----------------------------------
                // BOTTOM – REGISTER LINK
                // -----------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("New here?"),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, "/register"),
                      child: Text(
                        "Create an account",
                        style: TextStyle(color: green),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
