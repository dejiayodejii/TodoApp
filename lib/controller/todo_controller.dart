
// ignore_for_file: prefer_final_fields, unnecessary_this, invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/database.dart';



class ToDoController extends GetxController {
  
  RxList todoList = <ToDoModel>[].obs;

 List<dynamic> get todos => todoList.value;

 @override
  void onInit() {
    
    todoList.bindStream(DataBase().getTodoStream());
    super.onInit();
  }

  

  
}