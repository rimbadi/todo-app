import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'todo list', home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(
        () => _todoItems.add(task),
      );
    }
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Add a new task'),
        ),
        body: TextField(
          autofocus: true,
          onSubmitted: (value) {
            _addTodoItem(value);
            Navigator.pop(context);
          },
          decoration: InputDecoration(
              hintText: 'Enter something to do...',
              contentPadding: EdgeInsets.all(16.0)),
        ),
      );
    }));
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Mark "${_todoItems[index]}" ad done?'),
            actions: <Widget>[
              FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('CANCEL')),
              FilledButton(
                onPressed: () {
                  _removeTodoItem(index);
                  Navigator.of(context).pop();
                },
                child: Text('MARK AS DONE'),
              )
            ],
          );
        });
  }

  Widget _buildTodoList() {
    return ListView.builder(itemBuilder: (context, index) {
      if (index < _todoItems.length) {
        return _buildTodoItem(_todoItems[index],index);
      }
    });
  }

  Widget _buildTodoItem(String todoText,int index) {
    return ListTile(
      title: Text(todoText),
      onTap: () => _promptRemoveTodoItem(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }
}
