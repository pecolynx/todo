import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo/to_do_item.dart';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

// part 'to_do_provider.g.dart';

// @riverpod
// ToDoRepository toDoRepository(Ref ref) {
//   return ToDoRepository();
// }

// @riverpod
// Future<List<ToDoItem>> xxfetchToDoList(Ref ref) async {
//   final toDoRepository = ref.watch(toDoRepositoryProvider);
//   return toDoRepository.fetchToDoList();
// }

// final toDoListProvider = NotifierProvider<TodoListNotifier, List<ToDoItem>>(
//     () => TodoListNotifier());

class ToDoRepository {
  Future<List<ToDoItem>> fetchToDoList() async {
    return [
      ToDoItem(id: 1, title: 'First Item', isDone: false),
      ToDoItem(id: 2, title: 'Second Item', isDone: true),
    ];
  }

  Future<void> addTodo(ToDoItem todo) async {}
}

final toDoListNotifierProvider =
    AsyncNotifierProvider<ToDoListNotifier, List<ToDoItem>>(
        () => ToDoListNotifier());

// @riverpod
class ToDoListNotifier extends AsyncNotifier<List<ToDoItem>> {
  Future<List<ToDoItem>> _fetchTodo() async {
    final url = Uri.http('localhost:8080', 'api/todo');
    final response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    print(responseBody);
    List<ToDoItem> toDoList = ToDoItem.fromList(responseBody);
    // responseBody.map((json) => ToDoItem.fromJson(json)).toList();
    print(toDoList);
    final x = [
      ToDoItem(id: 1, title: 'First Item', isDone: false),
      ToDoItem(id: 2, title: 'Second Item', isDone: true),
    ];
    print(x);
    return toDoList;

    // return [
    //   ToDoItem(id: 1, title: 'First Item', isDone: false),
    //   ToDoItem(id: 2, title: 'Second Item', isDone: true),
    // ];
  }

  @override
  FutureOr<List<ToDoItem>> build() {
    return _fetchTodo();
  }

  Future<void> addTodo(ToDoItem todo) async {
    var newToDo = ToDoItem(
      id: 0,
      title: todo.title,
      isDone: false,
    );

    final currentState = [...state.requireValue];

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final url = Uri.http('localhost:8080', 'api/todo');
      final body = newToDo.toJson();
      print(body);
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      var responseBody = jsonDecode(response.body);
      newToDo.id = responseBody['id'] as int;
      return [...currentState, newToDo];
    });
  }

  Future<void> removeTodo(int id) async {
    final newState = state.requireValue.where((todo) => todo.id != id).toList();
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      var url = Uri.http('localhost:8080', 'api/todo/$id');
      final response = await http.delete(url);
      return newState;
    });
  }

  Future<void> toggleDone(int id) async {
    final currentToDo =
        state.requireValue.firstWhere((todo) => (id == todo.id));
    final newToDo = ToDoItem(
      id: currentToDo.id,
      title: currentToDo.title,
      isDone: !currentToDo.isDone,
    );

    final newState = state.requireValue
        .map((todo) => ((id == todo.id) ? newToDo : todo))
        .toList();
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      state = const AsyncLoading();
      final url = Uri.http('localhost:8080', 'api/todo/$id');
      final body = newToDo.toJson();
      print(body);
      final response = await http.put(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      var responseBody = jsonDecode(response.body);
      newToDo.id = responseBody['id'] as int;
      return newState;
    });
  }
}
