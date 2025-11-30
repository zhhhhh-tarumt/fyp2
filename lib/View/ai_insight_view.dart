import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart'; // IMPORT THIS
import '../Service/ai_insight_service.dart';
import '../Controller/expense_fetcher.dart';
import '../Model/expense_model.dart';

// ==========================================
// MODEL
// ==========================================
class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class AIInsightView extends StatefulWidget {
  const AIInsightView({super.key});

  @override
  State<AIInsightView> createState() => _AIInsightViewState();
}

class _AIInsightViewState extends State<AIInsightView> {
  final AIInsightService aiService = AIInsightService();
  final ExpenseFetcher expenseFetcher = ExpenseFetcher();
  final TextEditingController _questionController = TextEditingController();
  final ScrollController _scrollController = ScrollController(); // To auto-scroll

  bool isLoading = false;
  List<ChatMessage> _messages = []; 
  List<ExpenseModel> userExpenses = [];

  @override
  void initState() {
    super.initState();
    generateInitialInsight();
  }

  @override
  void dispose() {
    _questionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ==============================================================
  // LOGIC (Same as before, just keeps history)
  // ==============================================================
  Future<void> generateInitialInsight() async {
    setState(() => isLoading = true);
    userExpenses = await expenseFetcher.getAllExpenses();

    if (userExpenses.isEmpty) {
      _addMessage("You don't have any expenses yet. Add some to get started!", false);
      setState(() => isLoading = false);
      return;
    }

    String expenseText = userExpenses.map((e) => 
      "- RM ${e.amount} on ${e.category} (${e.note}) at ${e.date}"
    ).join("\n");

    String prompt = """
    You are a friendly financial assistant. Analyze this spending:
    $expenseText
    
    Format your response using Markdown (bold, lists). 
    Give a weekly summary, point out wasteful habits, and 3 tips.
    """;

    try {
      final response = await aiService.generateInsight(prompt);
      _addMessage(response, false);
    } catch (e) {
      _addMessage("AI Error: $e", false);
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _handleSendMessage() async {
    final question = _questionController.text.trim();
    if (question.isEmpty) return;

    _addMessage(question, true);
    _questionController.clear();
    FocusScope.of(context).unfocus();

    setState(() => isLoading = true);

    String expenseText = userExpenses.map((e) => 
      "- RM ${e.amount} on ${e.category}"
    ).join("\n");

    final fullPrompt = """
    User Question: $question
    User Data: $expenseText
    Answer helpful and concisely in Markdown.
    """;

    try {
      final reply = await aiService.generateInsight(fullPrompt);
      _addMessage(reply, false);
    } catch (e) {
      _addMessage("Error: $e", false);
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _addMessage(String text, bool isUser) {
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: isUser));
    });
    // Auto-scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ==============================================================
  // BEAUTIFUL UI BUILD
  // ==============================================================
  @override
  Widget build(BuildContext context) {
    // Define Theme Colors
    final primaryColor = Colors.green.shade800;
    final backgroundColor = Colors.grey.shade100;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Financial Insights", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      
      body: Column(
        children: [
          // CHAT AREA
          Expanded(
            child: _messages.isEmpty && isLoading
                ? _buildLoadingState() // Nice loading animation
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                    itemCount: _messages.length + (isLoading && _messages.isNotEmpty ? 1 : 0),
                    itemBuilder: (context, index) {
                      // Show loading bubble at the end if waiting
                      if (index == _messages.length) {
                        return _buildTypingIndicator(); 
                      }
                      return _buildBeautifulBubble(_messages[index]);
                    },
                  ),
          ),
          
          // INPUT AREA
          _buildModernInputBar(primaryColor),
        ],
      ),
    );
  }

  // ==============================================================
  // WIDGET: LOADING STATE (CENTER)
  // ==============================================================
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.green.shade600),
          const SizedBox(height: 16),
          Text(
            "Analyzing your finances...",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // WIDGET: TYPING INDICATOR (BOTTOM OF LIST)
  // ==============================================================
  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
             SizedBox(
               width: 16, height: 16, 
               child: CircularProgressIndicator(strokeWidth: 2, color: Colors.green)
             ),
             const SizedBox(width: 8),
             const Text("AI is thinking...", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // WIDGET: BEAUTIFUL BUBBLE
  // ==============================================================
  Widget _buildBeautifulBubble(ChatMessage message) {
    final isUser = message.isUser;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI AVATAR (Only show for AI)
          if (!isUser) ...[
            CircleAvatar(
              backgroundColor: Colors.green.shade100,
              child: Icon(Icons.auto_awesome, color: Colors.green.shade800, size: 20),
            ),
            const SizedBox(width: 8),
          ],

          // THE BUBBLE
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUser ? Colors.green.shade700 : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: isUser ? const Radius.circular(20) : Radius.zero,
                  bottomRight: isUser ? Radius.zero : const Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: isUser 
                // User Text (Simple)
                ? Text(
                    message.text,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  )
                // AI Text (Markdown Support)
                : MarkdownBody(
                    data: message.text,
                    styleSheet: MarkdownStyleSheet(
                      p: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                      strong: TextStyle(color: Colors.green.shade900, fontWeight: FontWeight.bold),
                      listBullet: TextStyle(color: Colors.green.shade900),
                    ),
                  ),
            ),
          ),
          
          // User Spacer (keeps user bubble from hitting right edge too hard)
          if (isUser) const SizedBox(width: 8),
        ],
      ),
    );
  }

  // ==============================================================
  // WIDGET: MODERN INPUT BAR
  // ==============================================================
  Widget _buildModernInputBar(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: _questionController,
                  decoration: const InputDecoration(
                    hintText: "Ask about your spending...",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: isLoading ? null : _handleSendMessage,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: isLoading ? Colors.grey : primaryColor,
                child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}