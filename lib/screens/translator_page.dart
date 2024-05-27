import 'package:flutter/material.dart';
import '../controllers/translation_controller.dart';

class TranslatorPage extends StatefulWidget {
  @override
  _TranslatorPageState createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  String _selectedLanguage = 'eng'; // Default language code
  late TranslationService _translationService;

  @override
  void initState() {
    super.initState();
    _translationService = TranslationService(apiKey: 'AIzaSyAnhYIWlFUEf0fxTalpsl4uBZ5FpfmIYlE');
  }

  Future<void> _translateText(String text) async {
    try {
      String translatedText = await _translationService.translateText(text, _selectedLanguage);
      setState(() {
        _outputController.text = translatedText;
      });
    } catch (e) {
      print('Error translating text: $e');
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
