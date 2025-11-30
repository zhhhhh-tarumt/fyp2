import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Auth
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesListView extends StatelessWidget {
  const ExpensesListView({super.key});

  // ... (Keep your existing _getCategoryIcon and _getCategoryColor methods here) ...
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Food & Drinks": return Icons.restaurant; 
      case "Transport": return Icons.train; 
      case "Shopping": return Icons.shopping_bag_outlined;
      case "Bills & Utilities": return Icons.electrical_services; 
      case "Entertainment": return Icons.movie_filter; 
      case "Groceries": return Icons.local_grocery_store; 
      case "Education": return Icons.school_outlined;
      case "Health": return Icons.local_hospital; 
      default: return Icons.category;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Food & Drinks": return Colors.orange.shade600;
      case "Transport": return Colors.blue.shade600;
      case "Shopping": return Colors.pink.shade600;
      case "Bills & Utilities": return Colors.red.shade600;
      case "Entertainment": return Colors.purple.shade600;
      case "Groceries": return Colors.green.shade700;
      case "Education": return Colors.teal.shade600;
      case "Health": return Colors.cyan.shade600;
      default: return Colors.grey.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.green.shade800;
    final uid = FirebaseAuth.instance.currentUser?.uid; // Get current User ID

    // Safety check: If not logged in, show empty state
    if (uid == null) {
      return const Center(child: Text("Please log in to view expenses"));
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("My Expenses"),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),

      // 🔥 FIXED DATA STREAM
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("expenses")
            .where("uid", isEqualTo: uid) // 1. Filter by User ID
            // 2. We sort by 'date' string because 'created_at' might be missing in manual entries
            // Note: Sorting by string date works well if format is "YYYY-MM-DD..."
            .orderBy("date", descending: true) 
            .snapshots(),
        builder: (context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.list_alt, size: 90, color: Colors.grey.shade300),
                  const SizedBox(height: 20),
                  Text(
                    "No expenses recorded yet",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              
              // Safe Data Parsing
              final amount = (data["amount"] ?? 0).toDouble();
              final category = data["category"] ?? "Others";
              final note = data["note"] ?? "";
              
              // Handle Date: Try 'date' string first, then 'created_at' timestamp
              String dateDisplay = "Unknown Date";
              if (data["date"] != null) {
                // If stored as "2024-11-30 14:00:00", parse it to display prettily
                try {
                  DateTime dt = DateTime.parse(data["date"].toString());
                  dateDisplay = DateFormat("dd MMM • hh:mm a").format(dt);
                } catch (e) {
                  dateDisplay = data["date"].toString();
                }
              } else if (data["created_at"] is Timestamp) {
                DateTime dt = (data["created_at"] as Timestamp).toDate();
                dateDisplay = DateFormat("dd MMM • hh:mm a").format(dt);
              }

              final categoryColor = _getCategoryColor(category);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Icon
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: categoryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getCategoryIcon(category),
                          size: 28,
                          color: categoryColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note.isEmpty ? category : note,
                              style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              dateDisplay, // Uses the safe date logic
                              style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      // Amount
                      Text(
                        "RM ${amount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}