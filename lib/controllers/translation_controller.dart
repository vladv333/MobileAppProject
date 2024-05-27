// translation_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

class TranslationService {
  final String apiKey;

  TranslationService({required this.apiKey});

  Future<String> translateText(String text, String targetLanguage) async {
    final response = await http.post(
      Uri.parse('https://translation.googleapis.com/language/translate/v2?key=$apiKey'),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        'q': text,
        'target': targetLanguage,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      String translatedText = responseData['data']['translations'][0]['translatedText'];

      // Save the translation to Firebase
      await saveTranslationToFirebase(text, translatedText, targetLanguage);

      return translatedText;
    } else {
      throw Exception('Failed to load translation: ${response.statusCode}');
    }
  }

  Future<void> saveTranslationToFirebase(String inputText, String translatedText, String language) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('translations');
    await ref.push().set({
      'inputText': inputText,
      'translatedText': translatedText,
      'language': language,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
}
