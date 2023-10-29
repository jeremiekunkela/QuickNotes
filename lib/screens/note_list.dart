import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/helper.dart';
import 'package:quick_notes/models/note.dart';
import 'package:quick_notes/providers/notes_provider.dart';
import 'package:quick_notes/screens/add_note_screen.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;

  const NoteList(this.notes, {Key? key});

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/empty_note_image.png', width: 400, height: 300),
            const SizedBox(height: 20),
            const Text(
              'Add a note to get started',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final notesModel = Provider.of<NotesModel>(context, listen: false);
        final note = notes[index];

        return Dismissible(
          key: Key(note.title),
          onDismissed: (direction) {
            final isArchive = direction == DismissDirection.startToEnd;
            final actionText = isArchive ? 'archived' : 'deleted';

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 1),
                content: Text('${note.title} $actionText'),
              ),
            );

            if (isArchive) {
              notesModel.archiveNote(note);
            } else {
              notesModel.deleteNote(note);
            }
          },
          background: buildDismissibleBackground(Colors.green, Icons.archive),
          secondaryBackground:
              buildDismissibleBackground(Colors.red, Icons.delete),
          child: GestureDetector(
            onTap: () {
              navigateToEditScreen(context, note);
            },
            child: buildNoteCard(context, note),
          ),
        );
      },
    );
  }

  Widget buildDismissibleBackground(Color color, IconData icon) {
    return Container(
      color: color,
      alignment:
          color == Colors.green ? Alignment.centerLeft : Alignment.centerRight,
      child: Icon(
        icon,
        color: Colors.white,
      ),
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
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppHelper.formatCurrentDate(),
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
