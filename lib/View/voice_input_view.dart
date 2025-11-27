import 'package:flutter/material.dart';
import '../Controller/voice_input_controller.dart';
import '../Model/expense_voice_model.dart';

class VoiceInputView extends StatefulWidget {
  const VoiceInputView({super.key});

  @override
  State<VoiceInputView> createState() => _VoiceInputViewState();
}

class _VoiceInputViewState extends State<VoiceInputView> {
  final VoiceInputController controller = VoiceInputController();
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

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
              _micUI(green),
              const SizedBox(height: 30),

              Text(
                controller.isListening ? "Listening..." : "Tap to Start Recording",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: green),
              ),

              const SizedBox(height: 20),
              Text(
                "Describe your expense. Example:\n“Bought lunch RM12 at McDonald's”",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),
              _actionButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _micUI(Color green) {
    return GestureDetector(
      onTap: () async {
        if (!controller.isListening) {
          bool ok = await controller.startListening();
          setState(() {});
        } else {
          controller.stopListening();
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: controller.isListening ? Colors.green.shade200 : Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 14),
          ],
        ),
        child: Icon(
          Icons.mic,
          size: 60,
          color: green,
        ),
      ),
    );
  }

  Widget _actionButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade800,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: () async {
          setState(() => isProcessing = true);

          controller.stopListening();

          ExpenseVoiceModel result = await controller.processWithAI();

          setState(() => isProcessing = false);

          Navigator.pushNamed(context, "/voicePreview", arguments: result);
        },
        child: isProcessing
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text("Analyze Input", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
