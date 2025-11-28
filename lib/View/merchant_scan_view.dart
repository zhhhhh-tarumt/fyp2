import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'transfer_money_view.dart';

class MerchantScanView extends StatefulWidget {
  const MerchantScanView({super.key});

  @override
  State<MerchantScanView> createState() => _MerchantScanViewState();
}

class _MerchantScanViewState extends State<MerchantScanView> {
  bool scanned = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> handleScan(String phoneNumber) async {
    // Look up Firestore user
    final userQuery = await _firestore
        .collection("users")
        .where("phoneNumber", isEqualTo: phoneNumber)
        .limit(1)
        .get();

    if (userQuery.docs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid QR: No such user")));
      return;
    }

    final user = userQuery.docs.first;

    // ❗ Prevent scanning yourself
    // (Handled inside TransferMoneyView also)

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TransferMoneyView(
          receiverName: user["username"],
          receiverPhoneNumber: phoneNumber,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text("Scan QR to Pay")),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text("Scan QR to Pay",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: green)),
          const SizedBox(height: 10),

          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: green, width: 3),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: MobileScanner(
                onDetect: (capture) {
                  if (scanned) return;
                  scanned = true;

                  final barcode = capture.barcodes.first;
                  final value = barcode.rawValue;

                  if (value != null) {
                    handleScan(value);   // ⭐ Pass phone number to Firestore lookup
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
