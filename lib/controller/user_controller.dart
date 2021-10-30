// ignore_for_file: prefer_final_fields, unnecessary_this

import 'package:get/get.dart';
import 'package:todo_app/models/user.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel().obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => this._userModel.value = value;

  void clear() {
    _userModel.value = UserModel();
  }
}