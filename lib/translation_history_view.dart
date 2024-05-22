import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TranslationHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translation History'),
      ),
      body: FutureBuilder(
        future: _fetchTranslationHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return Center(child: Text('No translation history found.'));
          } else {
            final translations = snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: translations.length,
              itemBuilder: (context, index) {
                final translation = translations[index];
                return ListTile(
                  title: Text(translation['inputText']),
                  subtitle: Text(translation['translatedText']),
                  trailing: Text(translation['language']),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchTranslationHistory() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('translations');
    final snapshot = await ref.get();
    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      return data.values.map((e) => Map<String, dynamic>.from(e)).toList();
    } else {
      return [];
    }
  }
}
