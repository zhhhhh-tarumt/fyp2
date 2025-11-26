import 'dart:ui';
import 'package:flutter/material.dart';

class ReceiveMoneyView extends StatelessWidget {
  const ReceiveMoneyView({super.key});

  @override
  Widget build(BuildContext context) {
    final darkGreen = Colors.green.shade900;
    final lightGreen = Colors.green.shade50;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Receive Money"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),

          // =============================================================
          // HEADER WITH BLUR + WALLET ID
          // =============================================================
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade700,
                  Colors.green.shade500,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                  color: Colors.green.shade300.withOpacity(0.4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Your Wallet ID",
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
                const SizedBox(height: 6),
                SelectableText(
                  "WLT-839201", // sample ID
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 45,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.copy, color: Colors.white),
                    label: const Text(
                      "Copy Wallet ID",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Wallet ID copied")),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // =============================================================
          // QR CODE BOX
          // =============================================================
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: lightGreen,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.green.shade200),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                  color: Colors.black.withOpacity(0.05),
                )
              ],
            ),
            child: Column(
              children: [
                Text(
                  "Scan to Send Money",
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  height: 240,
                  width: 240,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.qr_code,
                      size: 170,
                      color: Colors.green,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Let others scan this code to transfer money to your wallet.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // =============================================================
          // SHARE QR BUTTON
          // =============================================================
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.share, color: Colors.white),
              label: const Text(
                "Share My QR",
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
