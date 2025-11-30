import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ✅ IMPORT THE CONTROLLER
import '../Controller/expense_controller.dart';
import '../Model/expense_voice_model.dart';

class VoicePreviewView extends StatelessWidget {
  final ExpenseVoiceModel data;
  
  // ✅ Constructor to receive data directly
  const VoicePreviewView({super.key, required this.data});

  // Helper widget for rows
  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    Color? iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: iconColor ?? color),
          const SizedBox(width: 14),
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1. Initialize the controller
    final ExpenseController expenseController = ExpenseController();

    final primaryColor = Colors.green.shade900;
    final now = DateTime.now();
    final formattedDateTime = DateFormat("dd MMM yyyy • hh:mm a").format(now);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("AI Expense Review"),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- 💰 Amount and Category Card ---
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [primaryColor.withOpacity(0.9), primaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Total Amount",
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "RM ${data.amount.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 48,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.label, color: Colors.white, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                data.category,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // --- 📅 Date/Time Card ---
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildDetailRow(
                        icon: Icons.calendar_today_outlined,
                        label: "Date & Time",
                        value: formattedDateTime,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // --- 📝 Note & Transcription ---
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildDetailRow(
                        icon: Icons.edit_note,
                        label: "Note",
                        value: data.note.isEmpty ? "No Note" : data.note,
                        color: Colors.black87,
                      ),
                      const Divider(height: 1, thickness: 1, indent: 40),
                      _buildDetailRow(
                        icon: Icons.mic_external_on,
                        label: "Transcription",
                        value: data.transcript.isEmpty ? "(None)" : data.transcript,
                        color: Colors.black54,
                        iconColor: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // --- 💾 SAVE BUTTON (UPDATED) ---
              SizedBox(
                height: 55,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle_outline, size: 24),
                  label: const Text(
                    "Confirm & Save Expense",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 5,
                  ),
                  onPressed: () async {
                    // 💡 CRITICAL FIX: Use the Controller to save!
                    // This function adds the missing UID and DATE automatically.
                    final result = await expenseController.addVoiceExpense(data);

                    if (context.mounted) {
                      if (result == "success") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Expense saved successfully!")),
                        );
                        // Go back to Home/Dashboard
                        Navigator.popUntil(context, (route) => route.isFirst);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: $result")),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}