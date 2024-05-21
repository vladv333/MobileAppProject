import 'package:android_project/translation_history_view.dart';
import 'package:flutter/material.dart';
import 'translator_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translator App',
      routes: {
        '/': (context) => TranslatorPage(),
        '/history': (context) => TranslationHistoryView()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
