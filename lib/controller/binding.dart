// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:todo_app/controller/user_controller.dart';
import 'package:todo_app/services/userauth.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.put<Authentication>(Authentication(), permanent: true);
    Get.put<UserController>(UserController(), permanent: true);

    }
}
