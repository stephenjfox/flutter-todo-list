import 'package:flutter/material.dart'
    show BuildContext, CircleAvatar, Color, Colors,
    ListTile, ObjectKey, StatelessWidget, Text,
    TextDecoration, TextStyle, Theme, Widget;

class Todo {
  const Todo({this.text});

  final String text;

  @override String toString() => "Todo[$text]";
}

typedef void TodoChangedCallback(Todo todo, bool checkState);

class TodoListItem extends StatelessWidget {

  TodoListItem({Todo todo, this.isChecked, this.onTodoClick})
      : todo = todo,
        super(key: new ObjectKey(todo));

  final Todo todo;
  final bool isChecked;
  final TodoChangedCallback onTodoClick;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different parts of the tree
    // can have different themes.  The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return isChecked ? Colors.black54 : Theme
        .of(context)
        .primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    return new TextStyle(
        color: Colors.black54,
        decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none
    );
  }


  @override
  Widget build(BuildContext context) {
    return new ListTile(
        onTap: () {
          onTodoClick(this.todo, isChecked);
        },
        leading: new CircleAvatar(
          backgroundColor: _getColor(context),
          child: new Text(todo.text[0]),
        ),
        title: new Text(todo.text,
          style: _getTextStyle(context),
        )
    );
  }
}