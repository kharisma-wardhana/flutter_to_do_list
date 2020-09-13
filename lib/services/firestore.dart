import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dicoding_todo/models/Task.dart';

class TaskStore {
  final pathCollection = FirebaseFirestore.instance.collection("tasks");
  DocumentReference doc;

  createTask(Task task) {
    doc = pathCollection.doc(task.id);
    Map<String, dynamic> mapTask = {
      'id': task.id,
      'title': task.title,
      'desc': task.desc,
      'createdAt': task.createdAt,
      'updatedAt': task.updatedAt
    };

    doc.set(mapTask).whenComplete(
        () => print('task with title ${task.title} successfully created'));
  }

  editTask(Task task) async {
    print('Checked Id Edited data ${task.id}');
    doc = pathCollection.doc(task.id);
    Map<String, dynamic> mapTask = {
      'id': task.id,
      'title': task.title,
      'desc': task.desc,
      'createdAt': task.createdAt,
      'updatedAt': task.updatedAt
    };
    bool isSuccess = false;
    await doc.update(mapTask).whenComplete(() => isSuccess = true);
    return isSuccess;
  }

  deleteTask(id) {
    doc = pathCollection.doc(id);
    doc
        .delete()
        .whenComplete(() => print('task with id $id successfully deleted'));
  }
}
