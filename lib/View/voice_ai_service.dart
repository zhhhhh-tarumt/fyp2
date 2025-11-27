import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/expense_voice_model.dart';

class VoiceAIService {
  final String apiURL = "https://your-api-endpoint.com/analyze_expense";

  Future<ExpenseVoiceModel> analyzeText(String text) async {
    final response = await http.post(
      Uri.parse(apiURL),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"voice_text": text}),
    );

    final data = jsonDecode(response.body);
    return ExpenseVoiceModel.fromMap(data);
  }
}
