// ignore_for_file: avoid_print, prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/user_controller.dart';
import 'package:todo_app/models/user.dart';
// ignore_for_file: file_names
import 'package:todo_app/services/database.dart';

class Authentication extends GetxController {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();

  User? get user {
    return _firebaseUser.value;
  }

  @override
  void onInit() {
    _firebaseUser.bindStream(_firebaseAuth.userChanges());
    super.onInit();
  }


 void createUser(String name, String email, String password) async {
    try {
      UserCredential _authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      UserModel _user = UserModel(
        id: _authResult.user!.uid,
        name: name,
        email: _authResult.user!.email,
      );
      if (await DataBase().createNewUser(_user)) {
        Get.find<UserController>().user = _user;
        Get.back(); 
      }
    }  on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    try {
    UserCredential _authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
       Get.find<UserController>().user =
          await DataBase().getUser(_authResult.user!.uid); 
    }  on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error signing in",
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await _firebaseAuth.signOut();
      Get.find<UserController>().clear();
    }  on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error signing out",
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}



