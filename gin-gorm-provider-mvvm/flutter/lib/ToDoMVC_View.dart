import 'package:todo/ToDoMVC_Controller.dart';
import 'package:flutter/material.dart';

class ToDoView extends StatefulWidget {
  const ToDoView({super.key});

  @override
  _ToDoViewState createState() => _ToDoViewState();
}

class _ToDoViewState extends State<ToDoView> {
  late ToDoController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ToDoController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MVC ToDo List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Add ToDo Item',
              ),
              onSubmitted: (value) {
                setState(() {
                  _controller.addItem(value);
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _controller.toDoList.length,
              itemBuilder: (context, index) {
                final item = _controller.toDoList[index];
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
                      setState(() {
                        _controller.toggleItemDone(index);
                      });
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _controller.deleteItem(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
