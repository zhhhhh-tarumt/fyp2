import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  // For Android emulator: 10.0.2.2 points to your PC's localhost
  static const String _baseUrl = 'http://10.0.2.2:5000';

  Future<String> createPaymentIntent(double amount) async {
    final url = Uri.parse('$_baseUrl/api/payments/create-intent');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'amount': amount, // e.g. 25.50 -> backend multiplies * 100
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final clientSecret = data['clientSecret'];

      if (clientSecret == null) {
        throw Exception('clientSecret missing in response');
      }

      return clientSecret as String;
    } else {
      throw Exception(
        'Failed to create PaymentIntent: '
        'status ${response.statusCode}, body: ${response.body}',
      );
    }
  }
}
