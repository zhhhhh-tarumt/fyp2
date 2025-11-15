import 'package:flutter/material.dart';
import 'package:fyp2/View/reload_money_view.dart';

// AUTH
import 'View/login_view.dart';
import 'View/register_view.dart';
import 'View/reset_password_view.dart';
import 'View/pin_authorize_view.dart';

// MAIN NAVIGATION
import 'View/navigation_view.dart';

// HOME PAGE (Dashboard)
import 'View/home_view.dart';

// EXPENSE MODULE
import 'View/expense_home_view.dart';
import 'View/add_expense_view.dart';
import 'View/add_expense_shortcut_view.dart';
import 'View/voice_input_view.dart';
import 'View/voice_preview_view.dart';
import 'View/expense_success_view.dart';
import 'View/select_category_view.dart';
import 'View/cashflow_view.dart';

// TEAMMATE MODULES
import 'View/analysis_view.dart';
import 'View/ai_insight_view.dart';
import 'View/bnpl_view.dart';
import 'View/payment_view.dart';

// MONEY FEATURES
import 'View/transfer_money_view.dart';
import 'View/receive_money_view.dart';
import 'View/expense_input_simple_view.dart';
import 'View/merchant_scan_view.dart';

// PROFILE & SETTINGS
import 'View/settings_view.dart';
import 'View/profile_view.dart';

// NEW SETTINGS SUB-PAGES
import 'View/notification_view.dart';
import 'View/language_view.dart';
import 'View/appearance_view.dart';
import 'View/faq_view.dart';
import 'View/support_view.dart';
import 'View/about_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Finance Tracker",
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),

      initialRoute: "/login",

      routes: {
        // -----------------------------------
        // AUTHENTICATION ROUTES
        // -----------------------------------
        "/login": (context) => const LoginView(),
        "/register": (context) => RegisterView(),
        "/resetPassword": (context) => const ResetPasswordView(),
        "/pinAuthorize": (context) => const PinAuthorizeView(),

        // -----------------------------------
        // MAIN NAVIGATION
        // -----------------------------------
        "/nav": (context) => const NavigationView(),

        // -----------------------------------
        // HOME + EXPENSE MODULE
        // -----------------------------------
        "/home": (context) => const HomeView(),
        "/expenseHome": (context) => const ExpenseHomeView(),
        "/addExpense": (context) => const AddExpenseView(),
        "/addShortcut": (context) => const AddExpenseShortcutView(),
        "/voiceInput": (context) => const VoiceInputView(),
        "/voicePreview": (context) => const VoicePreviewView(),
        "/expenseSuccess": (context) => const ExpenseSuccessView(),
        "/selectCategory": (context) => const SelectCategoryView(),
        "/cashflow": (context) => const CashFlowView(),

        // -----------------------------------
        // TEAMMATE MODULES
        // -----------------------------------
        "/analysis": (context) => const AnalysisView(),
        "/aiInsight": (context) => const AIInsightView(),
        "/bnpl": (context) => const BNPLView(),
        "/payment": (context) => const PaymentView(),

        // -----------------------------------
        // MONEY RELATED
        // -----------------------------------
        "/reloadMoney": (context) => const ReloadMoneyView(),
        "/transfer": (context) => TransferMoneyView(),
        "/receive": (context) => const ReceiveMoneyView(),
        "/quickExpense": (context) => ExpenseInputSimpleView(),
        "/merchantScan": (context) => const MerchantScanView(),

        // -----------------------------------
        // SETTINGS + PROFILE
        // -----------------------------------
        "/settings": (context) => const SettingsView(),
        "/profile": (context) => const ProfileView(),

        // -----------------------------------
        // SETTINGS SUB-PAGES
        // -----------------------------------
        "/notifications": (context) => const NotificationView(),
        "/language": (context) => const LanguageView(),
        "/appearance": (context) => const AppearanceView(),
        "/faq": (context) => const FAQView(),
        "/support": (context) => const SupportView(),
        "/about": (context) => const AboutView(),
      },
    );
  }
}
