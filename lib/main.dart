// lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// IMPORTANT: Ensure you have a 'screens' folder with 'login_screen.dart' inside.
import 'login_page.dart'; 

void main() async {
  // 1. Ensure Flutter is initialized before calling native code (like Firebase)
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Initialize Firebase
  // This is required for your Authentication, Firestore, and other backend features.
  try {
    // Note: You must run 'flutterfire configure' and have the 
    // generated 'firebase_options.dart' file for this to work in production.
    // For a minimal setup, we assume basic initialization is sufficient.
    await Firebase.initializeApp();
    print("Firebase initialized successfully.");
  } catch (e) {
    // If you run into issues, check the terminal output for configuration errors.
    print("Firebase initialization failed: $e");
    // In a real app, you would show an error message to the user.
  }

  // 3. Run the main application widget
  runApp(const FinancialTrackerApp());
}

class FinancialTrackerApp extends StatelessWidget {
  const FinancialTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Financial Tracker',
      debugShowCheckedModeBanner: false, // Hides the debug banner
      theme: ThemeData(
        // Set up the primary color scheme for a clean, professional look
        primarySwatch: Colors.green,
        primaryColor: Colors.green.shade700,
        hintColor: Colors.grey.shade600,
        fontFamily: 'Roboto', 
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true, // Use the latest Material Design standard
      ),
      // The 'home' property sets the first screen the user sees.
      home: const LoginScreen(),
      // Define named routes for better navigation structure
      routes: {
        // You'll add more routes here as you build the app:
        // '/home': (context) => const HomeScreen(), 
        // '/signup': (context) => const SignUpScreen(),
        // '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}