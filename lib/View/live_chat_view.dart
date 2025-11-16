import 'package:flutter/material.dart';

class LiveChatView extends StatefulWidget {
  const LiveChatView({super.key});

  @override
  State<LiveChatView> createState() => _LiveChatViewState();
}

class _LiveChatViewState extends State<LiveChatView> {
  final List<Map<String, dynamic>> messages = [
    {
      "fromSupport": true,
      "text": "Hi! 👋 Welcome to BudgetMate live support.",
    },
    {
      "fromSupport": true,
      "text": "How can we assist you today?",
    },
  ];

  final TextEditingController msgController = TextEditingController();
  bool supportTyping = false;

  void sendMessage() {
    if (msgController.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "fromSupport": false,
        "text": msgController.text.trim(),
      });
    });

    msgController.clear();

    // Fake support reply
    setState(() => supportTyping = true);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        supportTyping = false;
        messages.add({
          "fromSupport": true,
          "text": "Thank you for your message! Our team will get back shortly.",
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Chat"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // CHAT LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length + (supportTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == messages.length && supportTyping) {
                  return _typingIndicator();
                }

                final message = messages[index];
                return _chatBubble(
                  message["text"],
                  message["fromSupport"],
                );
              },
            ),
          ),

          // MESSAGE INPUT
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              border: Border(top: BorderSide(color: Colors.green.shade200)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: msgController,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: sendMessage,
                  icon: Icon(Icons.send, color: green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // CHAT BUBBLE
  Widget _chatBubble(String text, bool fromSupport) {
    final green = Colors.green.shade900;

    return Align(
      alignment: fromSupport ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: fromSupport ? Colors.green.shade100 : Colors.green.shade300,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: fromSupport ? green : Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _typingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text("Support is typing"),
            SizedBox(width: 6),
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          ],
        ),
      ),
    );
  }
}
