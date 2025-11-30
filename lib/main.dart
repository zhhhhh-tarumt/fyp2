import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fyp2/View/expense_form_view.dart';
import 'package:fyp2/View/monthly_report_view.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

// AUTH
import 'View/login_view.dart';
import 'View/register_view.dart';
import 'View/reset_password_view.dart';
import 'View/pin_authorize_view.dart';

// MAIN NAVIGATION
import 'View/navigation_view.dart';

// HOME + MAIN
import 'View/home_view.dart';

// EXPENSE MODULE
import 'View/expense_home_view.dart';
import 'View/add_expense_view.dart';
import 'View/voice_input_view.dart';
import 'View/voice_preview_view.dart';
import 'View/expense_success_view.dart';
import 'View/select_category_view.dart';
import 'View/cashflow_view.dart';
import 'View/expenses_list_view.dart';

// TEAMMATE MODULES
import 'View/analysis_view.dart';
import 'View/ai_insight_view.dart';
import 'View/bnpl_view.dart';
import 'View/payment_view.dart';

// MONEY FEATURES
import 'View/transfer_contact_view.dart';
import 'View/receive_money_view.dart';
import 'View/merchant_scan_view.dart';
import 'View/deposit_view.dart';
import 'View/history_view.dart';

// SETTINGS & PROFILE
import 'View/settings_view.dart';
import 'View/profile_view.dart';

// SETTINGS SUB-PAGES
import 'View/alarm_view.dart';
import 'View/language_view.dart';
import 'View/appearance_view.dart';
import 'View/faq_view.dart';
import 'View/support_view.dart';
import 'View/about_view.dart';

// SUPPORT SUB-PAGES
import 'View/email_support_view.dart';
import 'View/live_chat_view.dart';
import 'View/report_problem_view.dart';
import 'View/app_feedback_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ❌ REMOVE FORCED LOGOUT
  // await FirebaseAuth.instance.signOut();  // DELETE THIS

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BudgetMate",
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),

      // -----------------------------------
      // AUTO LOGIN SETUP
      // -----------------------------------
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? "/login"
          : "/nav",

      routes: {
        // AUTH
        "/login": (context) => const LoginView(),
        "/register": (context) => RegisterView(),
        "/resetPassword": (context) => const ResetPasswordView(),
        "/pinAuthorize": (context) => const PinAuthorizeView(),

        // ROOT NAVIGATION
        "/nav": (context) => const NavigationView(),
        "/home": (context) => const HomeView(),

        // MONEY FLOW
        "/deposit": (context) => const DepositView(),
        "/history": (context) => const HistoryView(),
        "/transfer": (context) => TransferContactView(),
        "/receive": (context) => const ReceiveMoneyView(),
        "/merchantScan": (context) => const MerchantScanView(),
        "/monthlyReport": (_) => const MonthlyReportView(),

        // EXPENSE
        "/expenseHome": (context) => const ExpenseHomeView(),
        "/addExpense": (context) => const AddExpenseView(),
        "/voiceInput": (context) => const VoiceInputView(),
        "/expenseFormVoice": (_) => const ExpenseFormView(),
        "/expenseSuccess": (context) => const ExpenseSuccessView(),
        "/selectCategory": (context) => const SelectCategoryView(),
        "/cashflow": (context) => const CashFlowView(),
        "/expensesList": (context) => const ExpensesListView(),

        // MODULES
        "/analysis": (context) => const AnalysisView(),
        "/aiInsight": (context) => const AIInsightView(),
        "/bnpl": (context) => const BNPLView(),
        "/payment": (context) => const PaymentView(),

        // SETTINGS
        "/settings": (context) => const SettingsView(),
        "/profile": (context) => const ProfileView(),
        "/notifications": (context) => const AlarmSettingsView(), // renamed
        "/language": (context) => const LanguageView(),
        "/appearance": (context) => const AppearanceView(),
        "/faq": (context) => const FAQView(),
        "/support": (context) => const SupportView(),
        "/about": (context) => const AboutView(),

        // SUPPORT PAGES
        "/emailSupport": (context) => const EmailSupportView(),
        "/liveChat": (context) => const LiveChatView(),
        "/reportProblem": (context) => const ReportProblemView(),
        "/feedback": (context) => const AppFeedbackView(),
      },
    );
  }
}