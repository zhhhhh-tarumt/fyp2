import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../Model/expense_voice_model.dart';
import '../Service/voice_ai_service.dart';

class VoiceInputController {
  final stt.SpeechToText speech = stt.SpeechToText();
  final VoiceAIService aiService = VoiceAIService();

  bool isListening = false;
  String recognizedText = "";

  Future<bool> startListening() async {
    bool available = await speech.initialize();
    if (!available) return false;

    isListening = true;
    speech.listen(onResult: (result) {
      recognizedText = result.recognizedWords;
    });

    return true;
  }

  void stopListening() {
    speech.stop();
    isListening = false;
  }

  /// Send the text to AI to extract {title, amount, category}
  Future<ExpenseVoiceModel> processWithAI() async {
    return await aiService.analyzeText(recognizedText);
  }
}
