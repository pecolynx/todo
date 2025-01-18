import 'package:flutter/material.dart';

import 'package:todo/to_do_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'riverpod',
        theme: ThemeData.light(),
        home: ToDoView(),
      ),
    ),
  );
}
