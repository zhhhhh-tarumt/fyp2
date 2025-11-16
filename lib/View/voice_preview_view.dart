import 'dart:ui';
import 'package:flutter/material.dart';

class VoicePreviewView extends StatefulWidget {
  const VoicePreviewView({super.key});

  @override
  State<VoicePreviewView> createState() => _VoicePreviewViewState();
}

class _VoicePreviewViewState extends State<VoicePreviewView> {
  final amount = TextEditingController(text: "12.50");
  final merchant = TextEditingController(text: "McDonald's");
  final desc = TextEditingController(text: "Lunch");

  String selectedCategory = "Food";

  final categories = ["Food", "Transport", "Shopping", "Bills", "Groceries"];

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Preview Expense"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================================
            // HEADER AI SUMMARY
            // ==========================================================
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade700, Colors.green.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade300.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.graphic_eq_rounded, size: 38, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "We've extracted the details from your voice input. Review them before saving.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.95),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ==========================================================
            // EXPENSE INPUT CARD
            // ==========================================================
            _glassCard(
              child: Column(
                children: [
                  _inputField(
                    icon: Icons.attach_money_rounded,
                    label: "Amount (RM)",
                    controller: amount,
                  ),
                  _inputField(
                    icon: Icons.store_mall_directory_rounded,
                    label: "Merchant",
                    controller: merchant,
                  ),
                  _inputField(
                    icon: Icons.description_rounded,
                    label: "Description",
                    controller: desc,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ==========================================================
            // CATEGORY SELECTION CHIPS
            // ==========================================================
            Text(
              "Select Category",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: categories.map((cat) {
                final bool selected = selectedCategory == cat;

                return GestureDetector(
                  onTap: () => setState(() => selectedCategory = cat),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: selected ? Colors.green.shade700 : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selected
                            ? Colors.green.shade700
                            : Colors.grey.shade300,
                      ),
                      boxShadow: selected
                          ? [
                              BoxShadow(
                                color: Colors.green.shade300.withOpacity(0.4),
                                blurRadius: 10,
                              )
                            ]
                          : [],
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.green.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 100), // space for footer button
          ],
        ),
      ),

      // ==========================================================
      // STICKY SAVE BUTTON
      // ==========================================================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -2),
            )
          ],
        ),
        child: SizedBox(
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () =>
                Navigator.pushNamed(context, "/expenseSuccess"),
            child: const Text(
              "Save Expense",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // REUSABLE GLASS CARD
  // ==========================================================
  Widget _glassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.65),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  // ==========================================================
  // INPUT FIELD WIDGET
  // ==========================================================
  Widget _inputField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.green.shade700),
            const SizedBox(width: 14),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: label,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        Divider(color: Colors.grey.shade300, height: 24),
      ],
    );
  }
}
