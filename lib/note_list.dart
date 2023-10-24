import 'package:flutter/material.dart';
import 'note.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;

  const NoteList(this.notes, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(notes[index].title),
          subtitle: Text(notes[index].description),
        );
      },
    );
  }
}
