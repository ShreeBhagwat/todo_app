import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/networking/todo.dart';
import 'package:todo_app/repo/todo_repo.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your todo';
                    }
                    return null;
                  },
                  controller: _controller,
                  decoration: const InputDecoration(
                      hintText: 'Add Todo',
                      border: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final todo = Todo(
                          id: 011,
                          todo: _controller.text,
                          completed: false,
                          userId: 01);
                      final response = await TodoRepo().addTodo(todo: todo);
                      log(response.toString());
                      _controller.clear();
                    }
                  },
                  child: const Text('Add'))
            ],
          ),
        ),
      ),
    );
  }
}
