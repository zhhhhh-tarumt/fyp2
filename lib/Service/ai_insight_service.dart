import 'dart:convert';
import 'package:http/http.dart' as http;

class AIInsightService {
  // IMPORTANT: Replace with your actual secure API Key
  final String apiKey = "AIzaSyDVG8ZrwIgtAhE-YCPANPLsbHcugUUhFlY"; 

  Future<String> generateInsight(String prompt) async {
    // 💡 FIX: Updated the API version to v1beta and the model name to gemini-2.5-flash
    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey",
    );

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Ensure you handle the case where candidates might be empty
        if (data["candidates"] != null && data["candidates"].isNotEmpty) {
          return data["candidates"][0]["content"]["parts"][0]["text"];
        }
        return "AI Error: Received successful status but no content.";
      } else {
        // Return the full body on error to help with debugging
        return "AI Error: Status ${response.statusCode}\nBody: ${response.body}";
      }
    } catch (e) {
      return "AI Error: $e";
    }
  }
}