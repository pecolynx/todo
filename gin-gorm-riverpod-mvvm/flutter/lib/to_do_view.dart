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
    // final AsyncValue<List<ToDoItem>> toDoList =
    //     ref.watch(futureToDoListProvider);
    // final va = ref.watch(toDoRepositoryProvider);
    // var list = ref.watch(xxfetchToDoListProvider);
    final toDoList = ref.watch(toDoListNotifierProvider);

    final todoListNotifier = ref.read(toDoListNotifierProvider.notifier);

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
                  ToDoItem todo = ToDoItem(
                    id: 0,
                    title: _textController.text,
                    isDone: false,
                  );

                  todoListNotifier.addTodo(todo);
                  _textController.clear();
                },
              ),
            ),
            Expanded(
              child: toDoList.when(
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => Text('Error: $error'),
                data: (toDoList) => ListView.builder(
                  itemCount: toDoList.length,
                  itemBuilder: (context, index) {
                    final item = toDoList[index];
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
                            todoListNotifier.toggleDone(toDoList[index].id),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () =>
                            todoListNotifier.removeTodo(toDoList[index].id),
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
