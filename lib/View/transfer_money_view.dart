import 'package:flutter/material.dart';

class TransferMoneyView extends StatefulWidget {
  final String receiverName;
  final String receiverPhone;

  const TransferMoneyView({
    super.key,
    required this.receiverName,
    required this.receiverPhone,
  });

  @override
  State<TransferMoneyView> createState() => _TransferMoneyViewState();
}

class _TransferMoneyViewState extends State<TransferMoneyView> {
  final amountCtrl = TextEditingController();
  final noteCtrl = TextEditingController(text: "Gift");

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade700;
    final lightGreen = Colors.green.shade50;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Transfer",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 15),

          // Receiver Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: lightGreen,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.green.shade200,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.receiverName,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.receiverPhone,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 25),

          // Amount Label
          const Text(
            "Amount",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),

          // Amount Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: lightGreen,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: green,
              ),
              decoration: InputDecoration(
                prefixText: "RM ",
                prefixStyle: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: green,
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // Note Label
          const Text(
            "What's the transfer for?",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),

          // Note Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: lightGreen,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: TextField(
              controller: noteCtrl,
              style: const TextStyle(fontSize: 17),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Send Button
          SizedBox(
            height: 55,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (amountCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter an amount")),
                  );
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Money sent successfully!"),
                  ),
                );
              },
              child: const Text(
                "Send Money",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}