import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/to_do_item.dart';
import 'package:todo/to_do_provider.dart';

class ToDoView extends ConsumerWidget {
  final _textController = TextEditingController();

  ToDoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');
    // List<ToDoItem> toDoList = ref.watch(toDoListProvider);
    final AsyncValue<List<ToDoItem>> toDoList =
        ref.watch(futureToDoListProvider);
    final va = ref.watch(toDoRepositoryProvider);
    var list = ref.watch(xxfetchToDoListProvider);

    TodoListNotifier todoListNotifier = ref.read(toDoListProvider.notifier);

    // return toDoList.when(
    //   loading: () => const CircularProgressIndicator(),
    //   error: (error, stackTrace) => Text('Error: $error'),
    //   data: (toDoList) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod MVVM ToDo List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Add ToDo Item',
                ),
                onSubmitted: (value) {
                  va.addTodo(ToDoItem(title: value));
                  // int id = (toDoList.isEmpty) ? 1 : toDoList.last.id + 1;
                  // ToDoItem todo = ToDoItem(
                  //   id: id,
                  //   title: _textController.text,
                  //   isDone: false,
                  // );

                  // todoListNotifier.addTodo(todo);
                  // _textController.clear();
                },
              ),
            ),
            Expanded(
              child: list.when(
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => Text('Error: $error'),
                data: (list) => ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return ListTile(
                      title: Text(
                        item.title,
                        style: TextStyle(
                          decoration: item.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      leading: Checkbox(
                        value: item.isDone,
                        onChanged: (value) =>
                            // todoListNotifier.toggleDone(toDoList[index].id),
                            todoListNotifier.toggleDone(index),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () =>
                            // todoListNotifier.removeTodo(toDoList[index].id),
                            todoListNotifier.removeTodo(index),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
    //   },
    // );
  }
}
