import 'package:flutter/material.dart';

class ExpenseHomeView extends StatelessWidget {
  const ExpenseHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade700;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Expense"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------------------------------------------------
            // CARD showing wallet + expense summary
            // ---------------------------------------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                    color: Colors.green.shade200.withOpacity(0.5),
                  )
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row (Wallet + category summary)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Wallet Info
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Wallet",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "RM 1,250.80",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      // Circle chart placeholder
                      Container(
                        height: 70,
                        width: 70,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white24,
                        ),
                        child: const Center(
                          child: Text(
                            "Chart",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Category bar
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.local_movies, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          "Entertainment",
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer(),
                        Text(
                          "-RM 350.00",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ---------------------------------------------------------
            // Title
            // ---------------------------------------------------------
            Text(
              "Track your money easily",
              style: TextStyle(
                color: green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),
            Text(
              "Get a clear view of your spending and make better decisions.",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 30),

            // ---------------------------------------------------------
            // Big Buttons
            // ---------------------------------------------------------
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, "/voiceInput");
                },
                icon: const Icon(Icons.mic),
                label: const Text("Add an Expense by Voice"),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, "/addExpense");
                },
                icon: Icon(Icons.edit, color: green),
                label: Text(
                  "Add an Expense Manually",
                  style: TextStyle(color: green),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: green, width: 1.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}