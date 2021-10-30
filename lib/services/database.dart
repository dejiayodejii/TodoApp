// ignore_for_file: prefer_final_fields, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/services/userauth.dart';

class DataBase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var firebaseUser = FirebaseAuth.instance.currentUser;
  String uid = Get.find<Authentication>().user!.uid;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("users").doc(uid).get();

      return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> addToDo(
    String content,
  ) async {
    try {
      await _firestore.collection("Tasks").doc(firebaseUser!.uid).collection('todos').add({
        "Content": content,
        "Time": Timestamp.now(),
        "done": false,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<List<ToDoModel>> getTodoStream() {
    return _firestore
        .collection("Tasks")
        .doc(firebaseUser!.uid)
        .collection("todos")
        .snapshots()
        .map((QuerySnapshot query) {
      List<ToDoModel> todoList = [];
      query.docs.forEach((element) {
        todoList.add(ToDoModel.fromDocumentSnapshot(element));
      });
      print(todoList.length);
      print('aa');
      return todoList;
    });
  }
 
   
 Future<void> updateToDo(bool value, String todoID) async {
    try {
      await _firestore
          .collection("Tasks")
          .doc(firebaseUser!.uid)
          .collection('todos')
          .doc(todoID)
          .update({
        "done": value,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}




 /*  Stream<List<ToDoModel>> getTodoStream() {
    return _firestore.collection("Tasks").snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => ToDoModel.fromDocumentSnapshot(document))
        .toList());
  } */







  