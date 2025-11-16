import 'package:flutter/material.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  String selectedLang = "en";

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Language"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose your preferred language for BudgetMate.",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.shade100),
              ),
              child: Column(
                children: [
                  langTile("English", "en", green),
                  divider(),
                  langTile("Bahasa Melayu", "ms", green),
                  divider(),
                  langTile("中文 (Simplified)", "zh", green),
                  divider(),
                  langTile("தமிழ் (Tamil)", "ta", green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget langTile(String title, String code, Color green) {
    final bool isSelected = selectedLang == code;
    return ListTile(
      onTap: () {
        setState(() => selectedLang = code);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Language set to $title (UI demo only).")),
        );
      },
      title: Text(
        title,
        style: TextStyle(
          color: Colors.green.shade900,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: green)
          : Icon(Icons.radio_button_unchecked, color: Colors.grey.shade500),
    );
  }

  Widget divider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.green.shade100,
      indent: 16,
      endIndent: 16,
    );
  }
}
