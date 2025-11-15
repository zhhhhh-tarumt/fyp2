import 'package:flutter/material.dart';

class MerchantScanView extends StatelessWidget {
  const MerchantScanView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Merchant Scanner"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Text(
              "Scan merchant QR to pay",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              height: 240,
              width: 240,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: const Center(
                child: Icon(Icons.qr_code_scanner,
                    size: 150, color: Colors.green),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {},
              child: const Text("Upload QR from Gallery"),
            )
          ],
        ),
      ),
    );
  }
}
