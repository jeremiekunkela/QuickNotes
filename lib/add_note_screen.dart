import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/notes_model.dart';

class AddNoteScreen extends StatelessWidget {
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notesModel = Provider.of<NotesModel>(context);

    Future<void> _saveNote() async {
      String noteText = noteController.text;
      final List<String> lines = noteText.split('\n');

      if (lines.isNotEmpty) {
        String title = lines.first;
        String description = lines.sublist(1).join('\n');
        notesModel.addNote(title, description);
      }

      Navigator.pop(context);
    }

    return WillPopScope(
      onWillPop: () async {
        _saveNote();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: noteController,
                  maxLines: null,
                  showCursor: true,
                  cursorColor: Colors.black,
                  cursorWidth: 2,
                  cursorHeight: 30,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
