// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors,, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/todo_controller.dart';
import 'package:todo_app/controller/user_controller.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/services/userauth.dart';

class HomeScreen extends GetWidget<Authentication> { 
  ToDoController toDoController = Get.put(ToDoController());
  final TextEditingController _todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetX<UserController>(
          initState: (_) async {
            Get.find<UserController>().user =
                await DataBase().getUser(Get.find<Authentication>().user!.uid);
          },
          builder: (_) {
            if (_.user.name != null) {
              return Text("Welcome " + _.user.name!);
            } else {
              return Text("loading...");
            }
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              controller.signOut();
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeTheme(ThemeData.light());
              } else {
                Get.changeTheme(ThemeData.dark());
              }
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            "Add Todo Here:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _todoController,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (_todoController.text != '') {
                        DataBase().addToDo(_todoController.text,);
                        _todoController.clear();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          Text(
            "Your Todos",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
           Obx(()  { 
            if (Get.find<ToDoController>().todoList.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: Get.find<ToDoController>().todoList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(Get.find<ToDoController>().todoList[index].content, 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  ),
                                  ),
                              ),
                                Checkbox(
                                value: Get.find<ToDoController>().todoList[index].done, 
                                onChanged:(value){
                                  DataBase().updateToDo(value!,Get.find<ToDoController>().todoList[index].todoId);
                                } )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  print( '${Get.find<ToDoController>().todos.length}');
                  return Text('Loading');
                }
          }) 
          
        ],
      ),
    );
  }
}
