import 'dart:convert';
import 'package:http/http.dart' as http;

class TopupService {
  static const String baseUrl = "http://10.0.2.2:5000";

  Future<String> createTopupIntent(double amount) async {
    final url = Uri.parse("$baseUrl/api/topup/create-intent");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"amount": amount}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["clientSecret"];
    } else {
      throw Exception("Stripe Top-Up Failed: ${response.body}");
    }
  }
}
