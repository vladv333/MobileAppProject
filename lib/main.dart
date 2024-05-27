import 'package:android_project/screens/translation_history_view.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/translator_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
