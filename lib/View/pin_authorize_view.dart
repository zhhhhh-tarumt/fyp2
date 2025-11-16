import 'dart:async';
import 'package:flutter/material.dart';

class PinAuthorizeView extends StatefulWidget {
  const PinAuthorizeView({super.key});

  @override
  State<PinAuthorizeView> createState() => _PinAuthorizeViewState();
}

class _PinAuthorizeViewState extends State<PinAuthorizeView> {
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  int timerSeconds = 60;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();

    // auto focus first field
    Future.delayed(const Duration(milliseconds: 300), () {
      focusNodes[0].requestFocus();
    });
  }

  void startTimer() {
    timerSeconds = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timerSeconds == 0) {
        t.cancel();
      } else {
        setState(() => timerSeconds--);
      }
    });
  }

  void onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }

    if (index == 5 && value.isNotEmpty) {
      verifyOTP();
    }
  }

  void verifyOTP() {
    final code = controllers.map((c) => c.text).join();
    if (code.length == 6) {
      Navigator.pushReplacementNamed(context, "/nav");
    }
  }

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      backgroundColor: Colors.green.shade50,

      appBar: AppBar(
        backgroundColor: Colors.green.shade50,
        elevation: 0,
        iconTheme: IconThemeData(color: green),
        centerTitle: true,
        title: Text(
          "Verify PIN",
          style: TextStyle(
            color: green,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          children: [
            const SizedBox(height: 40),

            Text(
              "Enter the 6-digit code",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "We have sent a verification code to your phone/email.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.green.shade900.withOpacity(0.6),
              ),
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (i) {
                return _otpBox(i, green);
              }),
            ),

            const SizedBox(height: 25),

            timerSeconds > 0
                ? Text(
                    "Resend code in $timerSeconds seconds",
                    style: TextStyle(
                      color: Colors.green.shade800.withOpacity(0.6),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      startTimer();
                      for (var c in controllers) c.clear();
                      focusNodes[0].requestFocus();
                    },
                    child: Text(
                      "Resend Code",
                      style: TextStyle(
                        color: green,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

            const SizedBox(height: 50),

            // MANUAL VERIFY BUTTON
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
                onPressed: verifyOTP,
                child: const Text(
                  "Verify",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // OTP BOX
  Widget _otpBox(int index, Color green) {
    return Container(
      height: 58,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200, width: 1.3),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.green.shade100.withOpacity(0.4),
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Center(
        child: TextField(
          controller: controllers[index],
          focusNode: focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: green,
          ),
          decoration: const InputDecoration(
            counterText: "",
            border: InputBorder.none,
          ),
          onChanged: (value) => onChanged(value, index),
        ),
      ),
    );
  }
}
