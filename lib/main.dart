import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todos/helpers.dart';
import 'package:todos/todo.dart';
import 'package:todos/todo_list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // The application theme.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Foxy To-do List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final todoMap = <String, Todo>{};

  Future<Null> _createNewTodo(BuildContext context) async {
    String modalDialogResult = await promptForUserTextInput(context);

    if (modalDialogResult != null && modalDialogResult.isNotEmpty) {
      var todo = new Todo(text: modalDialogResult, isDone: false);
      setState(() {
        todoMap[todo.text] = todo;
        debugPrint('Todomap: ${JSON.encode(todoMap)}', wrapWidth: 80);
      });
    }
  }

  void _persistChangeToDb(Todo todo, bool isChecked) {
    setState(() {
      // only state mutation allowed in the app
      todoMap[todo.text].isDone = isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new TodoList(
          todoElements: todoMap.values.toList(),
          onTodoStateChanged: _persistChangeToDb
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _createNewTodo(context);
        },
        tooltip: 'Add New Todo',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
