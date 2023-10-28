import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/home_page.dart';
import 'package:quick_notes/notes_model.dart';

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
