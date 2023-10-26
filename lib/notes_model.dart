import 'package:flutter/material.dart';
import 'package:quick_notes/note.dart';

class NotesModel extends ChangeNotifier {
  List<Note> notes = [];

  void addNote(String title, String description) {
    Note newNote = Note(title: title, description: description);
    notes.add(newNote);
    notifyListeners();
  }

  void updateNote(Note oldNote, String newTitle, String newDescription) {
    final int noteIndex = notes.indexOf(oldNote);
    if (noteIndex != -1) {
      notes[noteIndex].updateTitle(newTitle);
      notes[noteIndex].description = newDescription;
      notifyListeners();
    }
  }
}
