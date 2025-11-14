import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// View imports
import 'View/analysis_page.dart';
import 'View/home_page.dart';
import 'View/login_page.dart';
import 'View/overview_page.dart';
import 'View/profile_page.dart';
import 'View/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print("Firebase initialized successfully.");
  } catch (e) {
    print("Firebase initialization failed: $e");
  }

  runApp(const FinancialTrackerApp());
}

class FinancialTrackerApp extends StatelessWidget {
  const FinancialTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Financial Tracker',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green.shade700,
        hintColor: Colors.grey.shade600,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),

      /// FIRST PAGE (Login first, not Home)
      home: const AnalysisPage(),

      /// APP ROUTES
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/overview': (context) => const OverviewPage(),
        '/analysis': (context) => const AnalysisPage(),


      },
    );
  }
}
