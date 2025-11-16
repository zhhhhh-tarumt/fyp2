import 'package:flutter/material.dart';

class TransferMoneyView extends StatefulWidget {
<<<<<<< Updated upstream
  final String receiverName;
  final String receiverPhone;

  const TransferMoneyView({
    super.key,
    required this.receiverName,
    required this.receiverPhone,
  });

=======
  const TransferMoneyView({super.key});

>>>>>>> Stashed changes
  @override
  State<TransferMoneyView> createState() => _TransferMoneyViewState();
}

class _TransferMoneyViewState extends State<TransferMoneyView> {
<<<<<<< Updated upstream
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
=======
  final receiverCtrl = TextEditingController();
  final amountCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Transfer Money"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --------------------------------------------------------
            // TITLE SECTION
            // --------------------------------------------------------
            Text(
              "Send To",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),

            const SizedBox(height: 12),

            // RECEIVER BOX
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.green.shade200,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: receiverCtrl,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone number / Email",
                      ),
                    ),
                  ),
                ],
              ),
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
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
=======
            // --------------------------------------------------------
            // AMOUNT SECTION
            // --------------------------------------------------------
            Text(
              "Enter Amount",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "RM",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: green,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: amountCtrl,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: green,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "0.00",
                        hintStyle: TextStyle(fontSize: 40, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
>>>>>>> Stashed changes
              ),
            ),
          ),

          const SizedBox(height: 25),

<<<<<<< Updated upstream
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
=======
            // --------------------------------------------------------
            // RECENT CONTACTS (TNG style)
            // --------------------------------------------------------
            Text(
              "Recent Contacts",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _recentContact("Ali"),
                  _recentContact("Wei"),
                  _recentContact("Siti"),
                  _recentContact("John"),
                  _recentContact("Maya"),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
>>>>>>> Stashed changes
      ),

      // --------------------------------------------------------
      // SEND BUTTON
      // --------------------------------------------------------
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 55,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              if (receiverCtrl.text.isEmpty || amountCtrl.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fill in all fields")),
                );
                return;
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        "Sent RM ${amountCtrl.text} to ${receiverCtrl.text}")),
              );

              amountCtrl.clear();
              receiverCtrl.clear();
            },
            child: const Text("Send Money",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------
  // RECENT CONTACT CIRCLE
  // --------------------------------------------------------
  Widget _recentContact(String name) {
    return Container(
      margin: const EdgeInsets.only(right: 14),
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.green.shade200,
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
