import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ToDoMVVM_ViewModel.dart';

class ToDoView extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  ToDoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MVVM ToDo List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Add ToDo Item',
              ),
              onSubmitted: (value) {
                Provider.of<TodoViewModel>(context, listen: false)
                    .addItem(value);
                _textController.clear();
              },
            ),
          ),
          Expanded(
            child: Consumer<TodoViewModel>(
              builder: (context, viewModel, child) {
                return ListView.builder(
                  itemCount: viewModel.toDoList.length,
                  itemBuilder: (context, index) {
                    final item = viewModel.toDoList[index];
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
                        onChanged: (value) {
                          viewModel.toggleItemDone(index);
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          viewModel.deleteItem(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
