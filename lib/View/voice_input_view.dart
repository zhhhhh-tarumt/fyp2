import 'dart:ui';
import 'package:flutter/material.dart';

class VoiceInputView extends StatelessWidget {
  const VoiceInputView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Voice Expense Input"),
        centerTitle: true,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ======================================================
              // FUTURISTIC GLOW MIC BUTTON
              // ======================================================
              Stack(
                alignment: Alignment.center,
                children: [
                  // Outer glow
                  Container(
                    height: screenWidth * 0.55,
                    width: screenWidth * 0.55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.green.shade300.withOpacity(0.35),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  // Middle soft blur ring
                  Container(
                    height: screenWidth * 0.45,
                    width: screenWidth * 0.45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade50.withOpacity(0.8),
                      border: Border.all(
                        color: Colors.green.shade200,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade200.withOpacity(0.35),
                          blurRadius: 25,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                  ),

                  // Main mic icon
                  Container(
                    height: screenWidth * 0.32,
                    width: screenWidth * 0.32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.mic_rounded,
                      size: screenWidth * 0.20,
                      color: green,
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.04),

              // ======================================================
              // TEXTS
              // ======================================================
              Text(
                "Tap to Start Recording",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: green,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                "Describe your expense in a single sentence.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: screenHeight * 0.05),

              // ======================================================
              // BUTTON
              // ======================================================
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, "/voicePreview"),
                  child: const Text(
                    "Start Recording",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
