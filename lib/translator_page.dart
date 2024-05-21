import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TranslatorPage extends StatefulWidget {
  @override
  _TranslatorPageState createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  String _selectedLanguage = 'eng'; // Default language code
  String _apiKey = 'AIzaSyAnhYIWlFUEf0fxTalpsl4uBZ5FpfmIYlE'; // Replace with your actual API key

  Future<void> _translateText(String text) async {
    final response = await http.post(
      Uri.parse('https://translation.googleapis.com/language/translate/v2?key=$_apiKey'),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        'q': text,
        'target': _selectedLanguage, // Target language code
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        _outputController.text =
        responseData['data']['translations'][0]['translatedText'];
      });
    } else {
      throw Exception('Failed to load translation: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('/history'),
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 12, top: 12),
              child: Icon(Icons.history),
            ),
          )
        ],
        title: Text('Translator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Enter text to translate',
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              items: <String>['es', 'fr', 'de', 'it', 'eng'] // Add more languages as needed
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _translateText(_inputController.text);
              },
              child: Text('Translate'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _outputController,
              decoration: const InputDecoration(
                labelText: 'Translated text',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
