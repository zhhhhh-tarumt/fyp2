import 'dart:async';
import 'package:flutter/material.dart';

class PinAuthorizeView extends StatefulWidget {
  const PinAuthorizeView({super.key});

  @override
  State<PinAuthorizeView> createState() => _PinAuthorizeViewState();
}

class _PinAuthorizeViewState extends State<PinAuthorizeView> {
  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  int timer = 60;
  Timer? countdownTimer;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = 60;
    canResend = false;
    countdownTimer?.cancel();
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (timer == 0) {
        setState(() {
          canResend = true;
          t.cancel();
        });
      } else {
        setState(() {
          timer--;
        });
      }
    });
  }

  String getPin() => controllers.map((c) => c.text).join();

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final method = ModalRoute.of(context)!.settings.arguments as String?;
    final green = Colors.green.shade800;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify PIN"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              method == "phone"
                  ? "A 6-digit PIN has been sent to your phone number."
                  : "A 6-digit PIN has been sent to your Gmail.",
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 45,
                  child: TextField(
                    controller: controllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    obscureText: true,
                    style: const TextStyle(fontSize: 22),
                    decoration: InputDecoration(
                      counterText: "",
                      filled: true,
                      fillColor: Colors.green.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.green.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: green, width: 1.5),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 16),

            Text(
              canResend
                  ? "Didn't receive the PIN?"
                  : "Resend available in $timer seconds",
            ),

            TextButton(
              onPressed: canResend
                  ? () {
                      startTimer();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("PIN resent!")),
                      );
                    }
                  : null,
              child: Text(
                "Resend PIN",
                style: TextStyle(
                  color: canResend ? green : Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                final pin = getPin();
                if (pin.length != 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("PIN must be 6 digits.")),
                  );
                  return;
                }
                Navigator.pushReplacementNamed(context, "/nav");
              },
              child: const Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }
}
