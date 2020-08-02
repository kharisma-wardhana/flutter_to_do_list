import 'package:flutter/material.dart';
import 'package:to_do_list/screens/add_item.dart';
import 'package:to_do_list/screens/edit_item.dart';

class ListItem extends StatefulWidget {
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  List<Widget> todos = [];

  _ListItemState() {
    todos.add(Text("Checklist1"));
    todos.add(Text("Checklist2"));
    todos.add(Text("Checklist3"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Color(0xFFF55D3E))),
                  color: Color(0xFFFFFFFF),
                  child: Text(
                    "Add Task",
                    style: TextStyle(
                        color: Color(0xFFF55D3E),
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddItem();
                    }));
                  },
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Color(0xFFF55D3E))),
                  color: Color(0xFFFFFFFF),
                  child: Text(
                    "Edit Task",
                    style: TextStyle(
                        color: Color(0xFFF55D3E),
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return EditItem();
                    }));
                  },
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: todos,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
