import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/all_todo_list.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AllTodoListScreen(),
    );
  }
}
