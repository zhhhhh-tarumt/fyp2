import 'package:flutter/material.dart';

class EmailSupportView extends StatefulWidget {
  const EmailSupportView({super.key});

  @override
  State<EmailSupportView> createState() => _EmailSupportViewState();
}

class _EmailSupportViewState extends State<EmailSupportView> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final messageCtrl = TextEditingController();

  String selectedCategory = "General Inquiry";

  final categories = [
    "General Inquiry",
    "Account Issue",
    "Payment Problem",
    "Bug Report",
    "Feature Request"
  ];

  void submitForm() {
    if (nameCtrl.text.isEmpty ||
        emailCtrl.text.isEmpty ||
        messageCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Message Sent!"),
        content: const Text(
          "Your support request has been sent to:\n\nsupport@budgetmate.com",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Support"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Fill in the form below and our support team will email you within 24 hours.",
              style: TextStyle(color: Colors.grey.shade700),
            ),

            const SizedBox(height: 25),

            // NAME
            _inputField("Your Name", nameCtrl),

            const SizedBox(height: 15),

            // EMAIL
            _inputField("Email Address", emailCtrl),

            const SizedBox(height: 15),

            // CATEGORY DROPDOWN
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCategory,
                  items: categories
                      .map((cat) =>
                          DropdownMenuItem(value: cat, child: Text(cat)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => selectedCategory = value!),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // MESSAGE
            TextField(
              controller: messageCtrl,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: "Message",
                alignLabelWithHint: true,
                filled: true,
                fillColor: Colors.green.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // SUBMIT
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
                onPressed: submitForm,
                child: const Text("Send Message"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.green.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
