// lib/views/translation_history_view.dart
import 'package:flutter/material.dart';

class TranslationHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translation History'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Translation history will be displayed here.'),
          ],
        ),
      ),
    );
  }
}
