// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo_app/services/userauth.dart';
import 'package:todo_app/views/home.dart';
import 'package:todo_app/views/login.dart';




class RootFolder extends GetWidget<Authentication> {
  

  @override
  Widget build(BuildContext context) {
    return Obx(
            () => (Get.find<Authentication>().user != null) ? HomeScreen() : LoginScreen()
    );
  }
}