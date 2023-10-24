import 'package:flutter/material.dart';
import 'note.dart';

class AddNoteScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final Function(Note) onNoteAdded;

  AddNoteScreen({super.key, required this.onNoteAdded});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Titre'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text;
                String description = descriptionController.text;

                Note newNote = Note(title: title, description: description);
                onNoteAdded(newNote);

                Navigator.pop(context);
              },
              child: Text('Ajouter la Note'),
            ),
          ],
        ),
      ),
    );
  }
}
