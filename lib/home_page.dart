import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/notes_model.dart';
import 'add_note_screen.dart';
import 'note.dart';
import 'note_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notesModel = Provider.of<NotesModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: NoteList(notesModel.notes),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 255, 145, 0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNoteScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
