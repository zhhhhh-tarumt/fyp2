import 'package:flutter/material.dart';
import '../Controller/transfer_controller.dart';
import 'transfer_success_view.dart';

class TransferMoneyView extends StatefulWidget {
  final String receiverName;
  final String receiverPhoneNumber;

  const TransferMoneyView({
    super.key,
    required this.receiverName,
    required this.receiverPhoneNumber,
  });

  @override
  State<TransferMoneyView> createState() => _TransferMoneyViewState();
}

class _TransferMoneyViewState extends State<TransferMoneyView> {
  final amountCtrl = TextEditingController();
  final noteCtrl = TextEditingController(text: "Gift");

  final TransferController controller = TransferController();

  String get formattedPhone {
    String p = widget.receiverPhoneNumber.substring(1);
    return "+60 ${p.substring(0, 2)} ${p.substring(2)}";
  }

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade700;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // receiver section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green.shade200,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.receiverName,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      Text(formattedPhone),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Amount
            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount (RM)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: noteCtrl,
              decoration: const InputDecoration(
                labelText: "What's the transfer for?",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                minimumSize: const Size(double.infinity, 55),
              ),
              onPressed: () async {
                double amount = double.tryParse(amountCtrl.text) ?? 0;

                final result = await controller.transferMoney(
                  amount: amount,
                  receiverPhone: widget.receiverPhoneNumber,
                  note: noteCtrl.text,
                );

                if (result == "success") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TransferSuccessView(
                        receiverName: widget.receiverName,
                        amount: amount,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result)),
                  );
                }
              },
              child: const Text("Send Money",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }
}
