import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/helper.dart';
import 'package:quick_notes/models/note.dart';
import 'package:quick_notes/providers/notes_provider.dart';

class ArchiveScreen extends StatelessWidget {
  final List<Note> archivedNotes;

  ArchiveScreen(this.archivedNotes);

  @override
  Widget build(BuildContext context) {
    final notesModel = Provider.of<NotesModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: archivedNotes.isEmpty
          ? Center(
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
            ))
          : ListView.builder(
              itemCount: archivedNotes.length,
              itemBuilder: (context, index) {
                final note = archivedNotes[index];
                return Dismissible(
                  key: Key(note.title),
                  onDismissed: (direction) {
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
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.green,
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.restore,
                      color: Colors.white,
                    ),
                  ),
                  child: buildNoteCard(context, note),
                );
              },
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
