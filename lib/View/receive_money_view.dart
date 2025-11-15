import 'package:flutter/material.dart';

class ReceiveMoneyView extends StatelessWidget {
  const ReceiveMoneyView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade800;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Receive Money"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Text(
              "Scan this QR to receive money",
              style: TextStyle(
                color: green,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: const Center(
                child: Icon(Icons.qr_code, size: 160, color: Colors.green),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {},
              child: const Text("Share My QR"),
            )
          ],
        ),
      ),
    );
  }
}
