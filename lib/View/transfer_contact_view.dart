import 'package:flutter/material.dart';
import 'transfer_money_view.dart';

class TransferContactView extends StatefulWidget {
  const TransferContactView({super.key});

  @override
  State<TransferContactView> createState() => _TransferContactViewState();
}

class _TransferContactViewState extends State<TransferContactView> {
  final searchCtrl = TextEditingController();

  final recentContacts = [
    {"name": "kiangzi", "phone": "+60 11-106 57548"},
    {"name": "Zhuo Lun", "phone": "+60 12-357 8682"},
  ];

  final allContacts = [
    {"name": "Ac", "phone": "+60 17-399 0422"},
    {"name": "Adrian", "phone": "+60 16-260 1181"},
    {"name": "annn", "phone": "+60 12-670 8020"},
    {"name": "AS PHOTO Taman Melawati", "phone": "+60 18-294 1118"},
  ];

  void goToTransfer(String name, String phone) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransferMoneyView(
          receiverName: name,
          receiverPhone: phone,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade700;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: green,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Transfer",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),

      body: Column(
        children: [
          // GREEN HEADER (Tab + Search Bar)
          Container(
            width: double.infinity,
            color: green,
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                const SizedBox(height: 10),

                // Search Bar (green theme)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "+60 ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: green,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchCtrl,
                            decoration: const InputDecoration(
                              hintText: "Enter name or phone number",
                              border: InputBorder.none,
                            ),
                            onSubmitted: (v) {
                              if (v.trim().isNotEmpty) {
                                goToTransfer(v.trim(), "+60 ****");
                              }
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.refresh, color: green),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // CONTACT LIST
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 20),

                // Recent header
                Text(
                  "Recent",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: green,
                  ),
                ),
                const SizedBox(height: 8),

                // Recent list
                ...recentContacts.map((c) => contactTile(c)).toList(),

                const SizedBox(height: 25),

                // All contacts header
                Text(
                  "All Contacts",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: green,
                  ),
                ),
                const SizedBox(height: 8),

                // All contacts
                ...allContacts.map((c) => contactTile(c)).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // CONTACT TILE (Green Avatar)
  Widget contactTile(Map c) {
    final green = Colors.green.shade700;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 23,
        backgroundColor: Colors.green.shade200,
        child: const Icon(Icons.person, color: Colors.white),
      ),
      title: Text(
        c["name"],
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        c["phone"],
        style: TextStyle(color: Colors.grey.shade600),
      ),
      onTap: () => goToTransfer(c["name"], c["phone"]),
    );
  }
}
