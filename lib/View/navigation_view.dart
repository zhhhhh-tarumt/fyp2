import 'package:flutter/material.dart';
import 'expense_home_view.dart';
import 'home_view.dart';
import 'analysis_view.dart';
import 'ai_insight_view.dart';
import 'settings_view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  int currentIndex = 0;

  final pages = const [
    HomeView(),
    AnalysisView(),
    ExpenseHomeView(),
    AIInsightView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade700;

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: green,
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Analysis"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: "Expenses"),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: "AI"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
