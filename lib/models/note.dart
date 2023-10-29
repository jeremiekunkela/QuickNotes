class Note {
  String title;
  String description;
  DateTime lastEditedTime;

  Note({
    required this.title,
    required this.description,
    required this.lastEditedTime,
  });

  void updateTitle(String newTitle) {
    title = newTitle;
    lastEditedTime = DateTime.now();
  }

  factory Note.createNew({required String title, required String description}) {
    return Note(
        title: title, description: description, lastEditedTime: DateTime.now());
  }
}
