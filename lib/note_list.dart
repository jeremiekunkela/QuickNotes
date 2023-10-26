import 'package:flutter/material.dart';
import 'package:quick_notes/add_note_screen.dart';
import 'note.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;

  const NoteList(this.notes, {Key? key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNoteScreen(
                  noteToEdit: notes[index],
                  isEditing: true,
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(notes[index].title),
            subtitle: Text(notes[index].description),
          ),
        );
      },
    );
  }
}
