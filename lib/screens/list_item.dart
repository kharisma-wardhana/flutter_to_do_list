import 'package:flutter/material.dart';
import 'package:to_do_list/screens/add_item.dart';
import 'package:to_do_list/screens/edit_item.dart';

class ListItem extends StatefulWidget {
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  List<Widget> todos = [];

  _ListItemState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List"),
      ),
      body: Row(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                child: Text("Add Task"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddItem();
                  }));
                },
              ),
              RaisedButton(
                child: Text("Edit Task"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditItem();
                  }));
                },
              )
            ],
          ),
          ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: todos,
              )
            ],
          ),
        ],
      ),
    );
  }
}
