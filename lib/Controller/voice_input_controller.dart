import 'dart:convert';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import '../Model/expense_voice_model.dart';

class VoiceInputController {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool isRecording = false;
  
  // ⚠️ Keep this secure!
  String geminiKey = "AIzaSyDVG8ZrwIgtAhE-YCPANPLsbHcugUUhFlY";

  Future<void> init() async {
    await Permission.microphone.request();
    await Permission.storage.request();
    await _recorder.openRecorder();
  }

  Future<void> dispose() async {
    await _recorder.closeRecorder();
  }

  Future<bool> startRecording() async {
    await _recorder.startRecorder(
      toFile: "voice.wav",
      codec: Codec.pcm16WAV,
      sampleRate: 16000,
      numChannels: 1,
      bitRate: 16000 * 16,
    );
    isRecording = true;
    return true;
  }

  Future<String?> stopRecording() async {
    if (!isRecording) return null;
    final path = await _recorder.stopRecorder();
    isRecording = false;
    return path;
  }

  Future<ExpenseVoiceModel> processAudioSmart(String audioPath) async {
    final audioBytes = File(audioPath).readAsBytesSync();
    final base64Audio = base64Encode(audioBytes);

    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$geminiKey",
    );

    final prompt = """
      You are an expense extraction AI.
      Transcribe the audio and extract:
      { "transcript": "string", "amount": number, "category": "string", "note": "string" }
      
      Rules:
      - Category must be one of: Food & Drinks, Transport, Shopping, Groceries, Bills & Utilities, Entertainment, Health, Education, Others
      - If unsure, use default: amount=0, category="Others", note="Not detected"
    """;

    final body = {
      "contents": [
        {
          "parts": [
            {"inline_data": {"mime_type": "audio/wav", "data": base64Audio}},
            {"text": prompt}
          ]
        }
      ]
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.body.contains("error")) throw Exception(response.body);

      final rawText = jsonDecode(response.body)["candidates"][0]["content"]["parts"][0]["text"];
      final cleanJsonString = rawText.replaceAll("```json", "").replaceAll("```", "").trim();
      final map = jsonDecode(cleanJsonString);

      return ExpenseVoiceModel(
        amount: (map["amount"] ?? 0).toDouble(),
        category: map["category"] ?? "Others",
        note: map["note"] ?? "",
        transcript: map["transcript"] ?? "",
        offlineFallback: false,
        uid: "", // Will be filled by ExpenseController
        date: "", // Will be filled by ExpenseController
      );
    } catch (e) {
      print("❌ Gemini ERROR: $e");
      return ExpenseVoiceModel(
        amount: 0,
        category: "Offline",
        note: "Cannot detect (offline)",
        transcript: "",
        offlineFallback: true,
        uid: "",
        date: "",
      );
    }
  }
}