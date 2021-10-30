import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoModel {
  String? content;
  bool? done;
  Timestamp? dateCreated;
  String? todoId;
  

  ToDoModel({this.content, this.done, this.dateCreated,});

  ToDoModel.fromDocumentSnapshot(DocumentSnapshot? documentSnapshot) {
    content = documentSnapshot!['Content'];
    dateCreated = documentSnapshot['Time'];
   todoId = documentSnapshot.id;
    done = documentSnapshot['done'];
  }
}
