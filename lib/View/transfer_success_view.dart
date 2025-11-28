import 'package:flutter/material.dart';
import 'home_view.dart';   // <-- CHANGE THIS TO YOUR HOME PAGE

class TransferSuccessView extends StatelessWidget {
  final String receiverName;
  final double amount;

  const TransferSuccessView({
    super.key,
    required this.receiverName,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade700;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 80, color: green),
              const SizedBox(height: 20),

              Text(
                "Transfer Successful!",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: green),
              ),

              const SizedBox(height: 15),
              Text(
                "You have sent RM ${amount.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 5),

              Text(
                "to $receiverName",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 40),

              // ================= DONE BUTTON =================
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  // Remove all previous pages until Home screen
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => HomeView()), 
                    (route) => false,
                  );
                },
                child: const Text(
                  "Done",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
