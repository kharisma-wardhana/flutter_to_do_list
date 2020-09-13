import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dicoding_todo/models/Task.dart';
import 'package:dicoding_todo/screens/pomodoro.dart';
import 'package:dicoding_todo/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_todo/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String taskId = '';
  String taskTitle = '';
  TextEditingController editTask = new TextEditingController();
  TaskStore taskStore = new TaskStore();

  List<String> info = <String>['About me'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomdoro App'),
        backgroundColor: kPrimaryColor,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String val) async {
              if (val == 'About me') {
                var url = 'https://github.com/kharisma-wardhana';
                if (await canLaunch(url)) {
                  await launch(
                    url,
                    forceSafariVC: true,
                    forceWebView: true,
                    enableJavaScript: true,
                  );
                } else {
                  throw 'Could not launch $url';
                }
              }
              return print('Infoo');
            },
            icon: Icon(Icons.info),
            itemBuilder: (BuildContext context) {
              return info.map((String value) {
                return PopupMenuItem<String>(value: value, child: Text(value));
              }).toList();
            },
          )
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: taskStore.pathCollection.snapshots(),
            builder: taskListBuilder),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          editTask.text = "";
          showDialog(context: context, builder: alertDialogAdd);
        },
        child: Icon(
          Icons.add,
          color: kTextColor,
        ),
        backgroundColor: kSecondaryColor,
      ),
    );
  }

  Widget taskListBuilder(BuildContext ctx, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Center(child: Text(snapshot.error.toString()));
    }

    QuerySnapshot querySnapshot = snapshot.data;

    return ListView.builder(
        itemCount: querySnapshot.size,
        itemBuilder: (ctx, id) {
          DocumentSnapshot ds = querySnapshot.docs[id];
          return Dismissible(
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                taskStore.deleteTask(ds.data()['id']);
              },
              key: Key(ds.data()['id']),
              child: Card(
                color: kPrimaryColor,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  title: Text(
                    ds.data()['title'],
                    style: TextStyle(color: kTextColor),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Pomodoro();
                    }));
                  },
                  onLongPress: () {
                    setState(() {
                      editTask.text = ds.data()['title'];
                      taskId = ds.data()['id'];
                    });
                    showDialog(context: context, builder: alertDialogEdit);
                  },
                ),
              ));
        });
  }

  Widget alertDialogAdd(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.all(20),
      backgroundColor: Color(0xFF203453),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text('Add Task'),
      titleTextStyle: TextStyle(color: kTextColor, fontSize: 25),
      content: TextField(
        onChanged: (String value) {
          taskTitle = value;
        },
        cursorColor: kTextColor,
        style: TextStyle(color: kTextColor, decorationColor: kTextColor),
        decoration: InputDecoration(
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: kTextColor)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kSecondaryColor)),
            focusColor: kTextColor,
            fillColor: kTextColor),
      ),
      actions: <Widget>[
        RaisedButton(
          color: kSecondaryColor,
          onPressed: () {
            var currentDate = DateTime.now().toIso8601String();
            setState(() {
              taskId = 'ID_$currentDate';
            });
            Task newTask = new Task(taskId, taskTitle, 'A new Desc',
                DateTime.now(), DateTime.now());
            taskStore.createTask(newTask);
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: <Widget>[
              Icon(
                Icons.note_add,
                size: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Add',
                style: TextStyle(color: kTextColor, fontSize: 16),
              ),
            ]),
          ),
        )
      ],
    );
  }

  Widget alertDialogEdit(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.all(20),
      backgroundColor: Color(0xFF203453),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text('Edit Task'),
      titleTextStyle: TextStyle(color: kTextColor, fontSize: 25),
      content: TextField(
        controller: editTask,
        onChanged: (String value) {
          taskTitle = value;
        },
        cursorColor: kTextColor,
        style: TextStyle(color: kTextColor, decorationColor: kTextColor),
        decoration: InputDecoration(
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: kTextColor)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kSecondaryColor)),
            focusColor: kTextColor,
            fillColor: kTextColor),
      ),
      actions: <Widget>[
        RaisedButton(
          color: kSecondaryColor,
          onPressed: () async {
            Task editedTask = new Task(taskId, taskTitle, 'A new Desc',
                DateTime.now(), DateTime.now());
            var successEdit = await taskStore.editTask(editedTask);
            if (successEdit) {
              Navigator.of(context).pop();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: <Widget>[
              Icon(
                Icons.edit,
                size: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Edit',
                style: TextStyle(color: kTextColor, fontSize: 16),
              ),
            ]),
          ),
        )
      ],
    );
  }
}
