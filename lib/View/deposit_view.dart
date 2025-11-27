import 'package:flutter/material.dart';
import '../Controller/deposit_controller.dart';

class DepositView extends StatefulWidget {
  const DepositView({super.key});

  @override
  State<DepositView> createState() => _DepositViewState();
}

class _DepositViewState extends State<DepositView> {
  final amountCtrl = TextEditingController();
  String selectedMethod = "Online Banking";

  final DepositController depositController = DepositController();

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Deposit Money"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade100,

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ---------------- AMOUNT CARD ----------------
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  "Enter Deposit Amount",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: green,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: amountCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "0.00",
                    prefixText: "RM ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ---------------- PAYMENT METHOD TITLE ----------------
          Text(
            "Select Payment Method",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: green,
            ),
          ),

          const SizedBox(height: 12),

          // ---------------- PAYMENT METHODS ----------------
          _methodTile("Online Banking"),
          _methodTile("Debit / Credit Card"),
          _methodTile("Touch ‘n Go Wallet"),
          _methodTile("FPX Payment"),

          const SizedBox(height: 40),

          // ---------------- DEPOSIT BUTTON ----------------
          SizedBox(
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () async {
                if (amountCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Enter amount first")),
                  );
                  return;
                }

                double amount = double.tryParse(amountCtrl.text) ?? 0;

                String status = await depositController.depositMoney(
                  amount,
                  selectedMethod,
                );

                if (status == "success") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Deposit Successful!")),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(status)),
                  );
                }
              },
              child: const Text(
                "Deposit Now",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- METHOD TILE UI ----------------
  Widget _methodTile(String method) {
    final selected = selectedMethod == method;

    return GestureDetector(
      onTap: () => setState(() => selectedMethod = method),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: selected ? Colors.green.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? Colors.green : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.account_balance,
                color: selected ? Colors.green : Colors.grey),
            const SizedBox(width: 14),
            Text(
              method,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.green.shade900 : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
