import 'package:flutter/material.dart';
import 'package:quick_notes/note.dart';

class NotesModel extends ChangeNotifier {
  List<Note> notes = [];

  void addNote(String title, String description) {
    Note newNote = Note(title: title, description: description);
    notes.add(newNote);
    notifyListeners();
  }
}
