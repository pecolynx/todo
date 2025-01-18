import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo/to_do_item.dart';

final toDoListProvider =
    StateNotifierProvider<TodoListNotifier, List<ToDoItem>>((ref) {
  return TodoListNotifier();
});

class TodoListNotifier extends StateNotifier<List<ToDoItem>> {
  TodoListNotifier() : super([]);

  void addTodo(ToDoItem todo) {
    state = [...state, todo];
  }

  void removeTodo(int index) {
    state = [
      ...state.sublist(0, index),
      ...state.sublist(index + 1),
    ];
  }

  // void removeTodo(int id) {
  //   state = state.where((todo) => todo.id != id).toList();
  // }

  void toggleDone(int index) {
    var todo = state[index];
    state = [
      ...state.sublist(0, index),
      ToDoItem(
        id: todo.id,
        title: todo.title,
        isDone: !todo.isDone,
      ),
      ...state.sublist(index + 1),
    ];
  }
  // void toggleDone(int id) {
  //   state = state
  //       .map((todo) => ((id == todo.id)
  //           ? ToDoItem(
  //               id: todo.id,
  //               title: todo.title,
  //               isDone: !todo.isDone,
  //             )
  //           : todo))
  //       .toList();
  // }
}
