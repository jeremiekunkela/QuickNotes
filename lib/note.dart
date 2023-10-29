class Note {
  String title;
  String description;
  DateTime createdTime;
  DateTime lastEditedTime;

  Note({
    required this.title,
    required this.description,
    required this.createdTime,
    required this.lastEditedTime,
  });

  void updateTitle(String newTitle) {
    title = newTitle;
    lastEditedTime = DateTime.now();
  }

  factory Note.createNew({required String title, required String description}) {
    final currentTime = DateTime.now();
    return Note(
      title: title,
      description: description,
      createdTime: currentTime,
      lastEditedTime: currentTime,
    );
  }
}
