import 'package:flutter/material.dart';
import '../Controller/deposit_controller.dart';
import '../service/payment_service.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class DepositView extends StatefulWidget {
  const DepositView({super.key});

  @override
  State<DepositView> createState() => _DepositViewState();
}

class _DepositViewState extends State<DepositView> {
  final amountCtrl = TextEditingController();
  String selectedMethod = "Online Banking";

  final DepositController depositController = DepositController();
  final PaymentService paymentService = PaymentService();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final green = Colors.green.shade900;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Deposit Money"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade100,

      body: Stack(
        children: [
          _buildContent(green),
          if (loading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget _buildContent(Color green) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _amountCard(green),
        const SizedBox(height: 25),
        _paymentMethod(green),
        const SizedBox(height: 40),
        _depositButton(green),
      ],
    );
  }

  Widget _amountCard(Color green) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _boxDecoration(),
      child: Column(
        children: [
          Text(
            "Enter Deposit Amount",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: green),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: amountCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "0.00",
              prefixText: "RM ",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentMethod(Color green) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Payment Method", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: green)),
        const SizedBox(height: 12),
        _methodTile("Debit / Credit Card"),
      ],
    );
  }

  Widget _methodTile(String method) {
    final selected = selectedMethod == method;

    return GestureDetector(
      onTap: () => setState(() => selectedMethod = method),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: _methodDecoration(selected),
        child: Row(
          children: [
            Icon(Icons.credit_card, color: selected ? Colors.green : Colors.grey),
            const SizedBox(width: 14),
            Text(method, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _depositButton(Color green) {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        onPressed: _startStripePayment,
        child: const Text("Deposit Now", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  Future<void> _startStripePayment() async {
    final amount = double.tryParse(amountCtrl.text) ?? 0;

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter a valid amount")));
      return;
    }

    setState(() => loading = true);

    try {
      // 1️⃣ Request PaymentIntent from backend
      final clientSecret = await paymentService.createPaymentIntent(amount);

      // 2️⃣ Confirm payment in Flutter
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "BudgetMate",
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      // 3️⃣ Update Firebase wallet
      final status = await depositController.depositMoney(amount, selectedMethod);

      if (status == "success") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Top Up Successful!")));
        Navigator.pop(context);
      } else {
        throw Exception(status);
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 3)),
      ],
    );
  }

  BoxDecoration _methodDecoration(bool selected) {
    return BoxDecoration(
      color: selected ? Colors.green.shade50 : Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: selected ? Colors.green : Colors.grey.shade300, width: selected ? 2 : 1),
    );
  }
}
