import 'package:flutter/material.dart';

class ReportProblemView extends StatelessWidget {
  const ReportProblemView({super.key});

  @override
  Widget build(BuildContext context) {
    final description = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Report a Problem"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Describe what went wrong and our team will investigate.",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: description,
              maxLines: 7,
              decoration: InputDecoration(
                hintText: "Describe the issue...",
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
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Report submitted!")));

                  Navigator.pop(context);
                },
                child: const Text("Submit Report"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
