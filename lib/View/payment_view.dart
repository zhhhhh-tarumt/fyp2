import 'package:flutter/material.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Make Payment"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Text("Select Payment Method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          ListTile(
            leading: const Icon(Icons.credit_card),
            title: const Text("Credit / Debit Card"),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text("FPX Online Banking"),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.qr_code),
            title: const Text("QR Pay"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
