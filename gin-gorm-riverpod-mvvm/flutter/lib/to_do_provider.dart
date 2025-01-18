import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo/to_do_item.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'to_do_provider.g.dart';

@riverpod
ToDoRepository toDoRepository(Ref ref) {
  return ToDoRepository();
}

@riverpod
Future<List<ToDoItem>> xxfetchToDoList(Ref ref) async {
  final toDoRepository = ref.watch(toDoRepositoryProvider);
  return toDoRepository.fetchToDoList();
}

class ToDoRepository {
  Future<List<ToDoItem>> fetchToDoList() async {
    return [
      ToDoItem(title: 'First Item', isDone: false),
      ToDoItem(title: 'Second Item', isDone: true),
    ];
  }

  Future<void> addTodo(ToDoItem todo) async {}
}

//
final toDoListProvider = NotifierProvider<TodoListNotifier, List<ToDoItem>>(
    () => TodoListNotifier());

class TodoListNotifier extends Notifier<List<ToDoItem>> {
  @override
  List<ToDoItem> build() => [];

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
