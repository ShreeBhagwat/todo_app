import 'dart:convert';

import 'package:todo_app/networking/dio_client.dart';
import 'package:todo_app/networking/todo.dart';

class TodoRepo {
  final DioClient _dioClient = DioClient([]);

  Future<List<Todo>> fetchAllTodos() async {
    final response = await _dioClient.get('/todos');
    final List<Todo> todoList = response.data['todos']
        .map<Todo>((todo) => Todo.fromJson(todo))
        .toList();
    return todoList;
  }

  Future addTodo({required Todo todo}) async {
    final encodedJson = jsonEncode(todo.toJson());
    final response = await _dioClient.post('/todos/add', body: encodedJson);
    return response.data;
  }
}
