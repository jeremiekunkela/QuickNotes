import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/screens/home_page_screen.dart';
import 'package:quick_notes/providers/notes_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NotesModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quick Notes',
      home: HomePage(),
    );
  }
}
