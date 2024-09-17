import 'package:flutter/material.dart';
import 'package:todo_app/repo/todo_repo.dart';
import 'package:todo_app/ui/screens/add_todo_screen.dart';

import '../../networking/todo.dart';

class AllTodoListScreen extends StatefulWidget {
  const AllTodoListScreen({super.key});

  @override
  State<AllTodoListScreen> createState() => _AllTodoListScreenState();
}

class _AllTodoListScreenState extends State<AllTodoListScreen> {
  List<Todo>? _allTodosList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTodos();
  }

  Future getAllTodos() async {
    final TodoRepo _todoRepo = TodoRepo();
    _allTodosList = await _todoRepo.fetchAllTodos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Todo List'),
        // actions: [IconButton(onPressed: () {}, icon: )],
      ),
      body: _allTodosList != null
          ? _allTodosList!.isNotEmpty
              ? ListView.separated(
                  itemCount: _allTodosList!.length,
                  itemBuilder: (context, index) {
                    final todo = _allTodosList![index];
                    return ListTile(
                      title: Text(todo.todo!),
                      trailing: todo.completed!
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : null,
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                )
              : const Center(
                  child: Text('No todos found, Please add some todo'),
                )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddTodoScreen()));

          // showModalBottomSheet(
          //     context: context,
          //     builder: (context) {
          //       return BottomSheet(
          //           onClosing: () {},
          //           builder: (context) {
                      
          //           });
          //     });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
