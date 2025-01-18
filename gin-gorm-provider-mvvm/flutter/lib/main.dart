import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo/to_do_view.dart';
import 'package:todo/to_do_view_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoViewModel(),
      child: MaterialApp(
        title: 'provider',
        theme: ThemeData.light(),
        home: ToDoView(),
      ),
    ),
  );
}
