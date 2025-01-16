import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo/ToDoMVVM_View.dart';
import 'package:todo/ToDoMVVM_ViewModel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoViewModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        home: ToDoView(),
      ),
    ),
  );
}

// import 'package:todo/ToDoMVC_View.dart';

// void main() {
//   runApp(MaterialApp(
//     title: 'Flutter Demo',
//     theme: ThemeData.light(),
//     home: ToDoView(),
//   ));
// }
