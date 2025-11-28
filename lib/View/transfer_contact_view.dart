import 'package:flutter/material.dart';
import '../Controller/transfer_contact_controller.dart';
import 'transfer_money_view.dart';

class TransferContactView extends StatefulWidget {
  const TransferContactView({super.key});

  @override
  State<TransferContactView> createState() => _TransferContactViewState();
}

class _TransferContactViewState extends State<TransferContactView> {
  final searchCtrl = TextEditingController();
  final TransferContactController controller = TransferContactController();

  bool isLoading = false;
  List<Map<String, dynamic>> contacts = [];

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    setState(() => isLoading = true);
    contacts = await controller.loadContacts();
    setState(() => isLoading = false);
  }

  Future<void> handleSearch(String value) async {
    if (value.trim().isEmpty) return;

    final result = await controller.findContactByInput(value.trim());

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not found")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TransferMoneyView(
          receiverName: result["name"],
          receiverPhoneNumber: result["phoneNumber"],
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
        title: const Text("Transfer"),
        backgroundColor: green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.all(16),
            color: green,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Text("+60 ", style: TextStyle(fontSize: 16, color: green)),
                  Expanded(
                    child: TextField(
                      controller: searchCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter phone (without 0)"),
                      onSubmitted: handleSearch,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh, color: green),
                    onPressed: loadContacts,
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (_, i) {
                      final c = contacts[i];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green.shade200,
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(c["name"]),
                        subtitle: Text(c["displayPhone"]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TransferMoneyView(
                                receiverName: c["name"],
                                receiverPhoneNumber: c["phoneNumber"],
                              ),
                            ),
                          );
                        },
                      );
                    }),
          )
        ],
      ),
    );
  }
}
