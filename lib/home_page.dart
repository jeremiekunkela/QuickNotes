import 'package:flutter/material.dart';
import 'add_note_screen.dart';
import 'note.dart';
import 'note_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];

  void addNote(Note newNote) {
    setState(() {
      notes.add(newNote);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: NoteList(notes),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNoteScreen(
                        onNoteAdded: addNote,
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
