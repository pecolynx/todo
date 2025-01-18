import 'package:flutter/material.dart';

import 'package:todo/to_do_view.dart';

void main() {
  runApp(MaterialApp(
    title: 'mvc',
    theme: ThemeData.light(),
    home: ToDoView(),
  ));
}
