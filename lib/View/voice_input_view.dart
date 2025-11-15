import 'package:flutter/material.dart';

class VoiceInputView extends StatelessWidget {
  const VoiceInputView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Voice Expense Input"),
      ),
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Round green mic container
              Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green.shade200, width: 2),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12,
                      color: Colors.green.shade100.withOpacity(0.4),
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Icon(
                  Icons.mic,
                  size: 100,
                  color: green,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                "Tap to Start Recording",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: green,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Describe your expense using your voice",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "/voicePreview"),
                  child: const Text(
                    "Start Recording",
                    style: TextStyle(fontSize: 18),
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
