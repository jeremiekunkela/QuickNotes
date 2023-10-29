import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/models/note.dart';
import 'package:quick_notes/providers/notes_provider.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? noteToEdit;
  final bool isEditing;

  AddNoteScreen({Key? key, this.noteToEdit, this.isEditing = false})
      : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController noteController = TextEditingController();
  final List<String> textHistory = [];
  int historyIndex = 0;
  late NotesModel notesModel;

  @override
  void initState() {
    super.initState();
    notesModel = Provider.of<NotesModel>(context, listen: false);

    if (widget.noteToEdit != null && widget.isEditing) {
      noteController.text =
          "${widget.noteToEdit!.title}\n${widget.noteToEdit!.description}";
    }

    textHistory.add(noteController.text);
  }

  void _saveNote(BuildContext context) {
    String noteText = noteController.text;
    String trimmedText = noteText.trim();
    if (trimmedText.isNotEmpty) {
      final List<String> lines = noteText.split('\n');
      String title = lines[0];
      String description = lines.sublist(1).join('\n');

      if (widget.isEditing) {
        notesModel.updateNote(widget.noteToEdit!, title, description);
      } else {
        notesModel.addNote(title, description);
      }
    } else {
      if (widget.isEditing) {
        notesModel.updateNote(widget.noteToEdit!, 'Untitled', '');
        noteController.text = 'Untitled\n';
      } else {
        notesModel.addNote('Untitled', '');
        noteController.text = 'Untitled\n';
      }
    }

    print('Note saved');
    Navigator.pop(context);
  }

  void _undo() {
    if (historyIndex > 0) {
      historyIndex--;
      noteController.text = textHistory[historyIndex];
    }
  }

  void _redo() {
    if (historyIndex < textHistory.length - 1) {
      historyIndex++;
      noteController.text = textHistory[historyIndex];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        buildAppBarIcons(Icons.undo, _undo),
        buildAppBarIcons(Icons.redo, _redo),
        buildAppBarIcons(Icons.check, () => _saveNote(context)),
      ],
    );
  }

  Widget buildAppBarIcons(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: const Color.fromARGB(92, 0, 0, 0),
        size: 24,
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildTextField(),
            ),
          ),
        ],
      ),
    );
  }

  TextField buildTextField() {
    return TextField(
      controller: noteController,
      maxLines: null,
      showCursor: true,
      cursorColor: Colors.black,
      cursorWidth: 2,
      cursorHeight: 30,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      onChanged: (newText) {
        if (newText != textHistory[historyIndex]) {
          textHistory.add(newText);
          historyIndex = textHistory.length - 1;
        }
      },
    );
  }
}
