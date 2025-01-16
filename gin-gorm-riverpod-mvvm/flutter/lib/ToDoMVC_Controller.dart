import 'package:todo/ToDoItem.dart';

class ToDoController {
  List<ToDoItem> toDoList = [];

  void addItem(String title) {
    toDoList.add(ToDoItem(title: title));
  }

  void toggleItemDone(int index) {
    toDoList[index].toggleDone();
  }

  void deleteItem(int index) {
    toDoList.removeAt(index);
  }
}
