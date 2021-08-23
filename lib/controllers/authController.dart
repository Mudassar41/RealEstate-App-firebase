import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/userModel.dart';
import 'package:haider/services/firebaseAuthService.dart';
import 'package:haider/services/firestoreService.dart';
import 'package:haider/utills/customColors.dart';
import 'package:haider/utills/customToast.dart';

class AuthController extends GetxController {
  // FirestoreService firestoreService = FirestoreService();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var currentUserId = ''.obs;
  var currentUser = false.obs;
  var isHidden = true.obs;
  var showLoadingDialog = false.obs;
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  UserModel userModel = UserModel();
  FirebaseAuthService authService = FirebaseAuthService();
  final emailTextEditController = TextEditingController();
  final passwordTextEditController = TextEditingController();
  final firstNameTextEditController = TextEditingController();
  final lastNameTextEditController = TextEditingController();
  final phoneTextEditController = TextEditingController();

  void setVisibility() {
    if (isHidden == true) {
      isHidden.value = false;
    } else {
      isHidden.value = true;
    }
  }

  void getCurrentUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        currentUser(false);
      } else {
        currentUser(true);
      }
    });
  }

  getCurrentUserId() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        currentUserId.value = user.uid;
        print(currentUserId.value);
        print('User is signed in!');
      }
    });

    // dynamic userId = FirebaseAuth.instance.currentUser!.uid;
    // if(currentUser!=null){
    //   currentUserId.value=userId;
    // }
    //CustomToast.showToast(userId);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    ///   print('yes');
    getCurrentUser();
    getCurrentUserId();
  }

  @override
  void refresh() {
    // TODO: implement refresh
    super.refresh();
    getCurrentUser();
  }
}
