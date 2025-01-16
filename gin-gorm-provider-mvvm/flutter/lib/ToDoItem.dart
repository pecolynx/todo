class ToDoItem {
  String title;
  bool isDone;
  ToDoItem({required this.title, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}
