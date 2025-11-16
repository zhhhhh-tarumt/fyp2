import 'package:flutter/material.dart';

class AppFeedbackView extends StatelessWidget {
  const AppFeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;
    final feedbackCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("App Feedback"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "We appreciate your feedback! Tell us how we can improve BudgetMate.",
              style: TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: feedbackCtrl,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: "Your feedback...",
                filled: true,
                fillColor: Colors.green.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Thank you for your feedback!")),
                  );
                  Navigator.pop(context);
                },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
