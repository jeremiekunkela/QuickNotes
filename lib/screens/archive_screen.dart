import 'package:flutter/material.dart';
import 'package:quick_notes/helper.dart';
import 'package:quick_notes/models/note.dart';
import 'package:quick_notes/providers/notes_provider.dart';

class ArchiveScreen extends StatelessWidget {
  final NotesModel notesModel = NotesModel();
  final List<Note> archivedNotes;

  ArchiveScreen(this.archivedNotes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: archivedNotes.isEmpty
          ? buildEmptyArchiveView()
          : buildArchiveListView(),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        'Archived Notes',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget buildEmptyArchiveView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/empty_archive_image.png',
              width: 400, height: 300),
          const SizedBox(height: 20),
          const Text(
            'No archived notes',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget buildArchiveListView() {
    return ListView.builder(
      itemCount: archivedNotes.length,
      itemBuilder: (context, index) {
        final note = archivedNotes[index];
        return Dismissible(
          key: Key(note.title),
          onDismissed: (direction) {
            handleDismissedItem(context, note, direction);
          },
          background: buildDismissBackground(
              Icons.delete, Colors.red, Alignment.centerLeft),
          secondaryBackground: buildDismissBackground(
              Icons.restore, Colors.green, Alignment.centerRight),
          child: buildNoteCard(context, note),
        );
      },
    );
  }

  void handleDismissedItem(
      BuildContext context, Note note, DismissDirection direction) {
    if (direction == DismissDirection.startToEnd) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: Text('${note.title} supprimée des archives'),
        ),
      );
      archivedNotes.remove(note);
    } else {
      notesModel.restoreNoteFromArchive(note);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: Text('${note.title} restaurée'),
        ),
      );
    }
  }

  Widget buildDismissBackground(
      IconData icon, Color color, Alignment alignment) {
    return Container(
      color: color,
      alignment: alignment,
      child: Icon(
        icon,
        color: Colors.white,
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
                color: Color(0xFF000000),
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
