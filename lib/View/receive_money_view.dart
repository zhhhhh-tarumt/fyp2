import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReceiveMoneyView extends StatefulWidget {
  const ReceiveMoneyView({super.key});

  @override
  State<ReceiveMoneyView> createState() => _ReceiveMoneyViewState();
}

class _ReceiveMoneyViewState extends State<ReceiveMoneyView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String phoneNumber = "";

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final doc = await _firestore.collection("users").doc(uid).get();

    setState(() {
      phoneNumber = doc["phoneNumber"];  // RAW FORMAT: "01110284657"
    });
  }

  @override
  Widget build(BuildContext context) {
    final darkGreen = Colors.green.shade900;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Receive Money"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Colors.green.shade700, Colors.green.shade500],
              ),
            ),
            child: Column(
              children: [
                const Text("Your Wallet Phone Number",
                    style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                SelectableText(
                  phoneNumber,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text("Scan to Send Money",
                    style: TextStyle(
                        color: darkGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                phoneNumber.isEmpty
                    ? const CircularProgressIndicator()
                    : QrImageView(
                        data: phoneNumber,   // ⭐ THIS IS WHAT WE SCAN
                        size: 240,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
