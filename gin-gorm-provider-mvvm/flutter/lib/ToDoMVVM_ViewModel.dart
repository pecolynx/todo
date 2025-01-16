import 'package:flutter/material.dart';
import 'package:todo/ToDoItem.dart';

class TodoViewModel extends ChangeNotifier {
  List<ToDoItem> toDoList = [];
  void addItem(String title) {
    toDoList.add(ToDoItem(title: title));
    notifyListeners();
  }

  void toggleItemDone(int index) {
    toDoList[index].toggleDone();
    notifyListeners();
  }

  void deleteItem(int index) {
    toDoList.removeAt(index);
    notifyListeners();
  }
}
