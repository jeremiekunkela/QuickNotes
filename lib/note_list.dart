import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/add_note_screen.dart';
import 'package:quick_notes/note.dart';
import 'package:quick_notes/notes_model.dart';
import 'package:intl/intl.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;

  const NoteList(this.notes, {Key? key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final notesModel = Provider.of<NotesModel>(context, listen: false);

        return Dismissible(
          key: Key(notes[index].title),
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Text('${notes[index].title} archivée'),
                ),
              );
              notesModel.archiveNote(notes[index]);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Text('${notes[index].title} supprimée'),
                ),
              );
              notesModel.deleteNote(notes[index]);
            }
          },
          background: Container(
            color: Colors.green,
            alignment: Alignment.centerLeft,
            child: const Icon(
              Icons.archive,
              color: Colors.white,
            ),
          ),
          secondaryBackground: Container(
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
    final dateFormat = DateFormat(' MMM dd, yyyy, hh:mm a');

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
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateFormat.format(note.lastEditedTime.toLocal()),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
