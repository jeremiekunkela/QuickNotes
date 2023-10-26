class Note {
  String title;
  String description;

  Note({required this.title, required this.description});

  void updateTitle(String newTitle) {
    title = newTitle;
  }
}
