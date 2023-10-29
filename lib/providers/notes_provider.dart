import 'package:flutter/material.dart';
import 'package:quick_notes/models/note.dart';

class NotesModel extends ChangeNotifier {
  List<Note> notes = [];
  List<Note> archivedNotes = [];

  void addNote(String title, String description) {
    Note newNote = Note(
        title: title,
        description: description,
        lastEditedTime: DateTime.now());
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

  void deleteNote(Note note) {
    notes.remove(note);
    notifyListeners();
  }

  void deleteAllNotes() {
    notes.clear();
    notifyListeners();
  }

  void archiveNote(Note note) {
    notes.remove(note);
    archivedNotes.add(note);
    notifyListeners();
  }

  void restoreNoteFromArchive(Note note) {
    archivedNotes.remove(note);
    notes.add(note);
    notifyListeners();
  }
}
