import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Welcome Back, User",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  /// Profile Icon
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// Balance Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Total Balance",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "RM 2,540.00",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// Quick Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _quickButton(Icons.arrow_upward, "Transfer", '/transfer'),
                  _quickButton(Icons.arrow_downward, "Receive", '/receive'),
                  _quickButton(Icons.receipt_long, "Expense", '/expense_input'),
                  _quickButton(Icons.pie_chart, "Analysis", '/analysis'),
                ],
              ),

              const SizedBox(height: 25),

              const Text(
                "Recent Transactions",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              /// Placeholder list
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.black12,
                        child: Icon(Icons.shopping_bag),
                      ),
                      title: Text("Transaction ${index + 1}"),
                      subtitle: const Text("Category • Today"),
                      trailing: const Text(
                        "-RM 25.00",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickButton(IconData icon, String text, String route) {
    return GestureDetector(
      onTap: () {
        // navigation will be handled in controller later
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 26, color: Colors.blueAccent),
          ),
          const SizedBox(height: 6),
          Text(text),
        ],
      ),
    );
  }
}
