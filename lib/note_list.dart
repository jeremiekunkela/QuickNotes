import 'package:flutter/material.dart';
import 'package:quick_notes/add_note_screen.dart';
import 'package:quick_notes/note.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;

  const NoteList(this.notes, {Key? key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(notes[index].title),
          onDismissed: (direction) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${notes[index].title} dismissed'),
              ),
            );
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                navigateToEditScreen(context, notes[index]);
              },
              child: buildNoteCard(context, notes[index]),
            ),
          ),
        );
      },
    );
  }

  void navigateToEditScreen(BuildContext context, Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNoteScreen(
          noteToEdit: note,
          isEditing: true,
        ),
      ),
    );
  }

  Widget buildNoteCard(BuildContext context, Note note) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              note.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(162, 0, 0, 0),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 100,
              ),
              child: Text(
                note.description,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
