import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/authController.dart';
import 'package:haider/models/userModel.dart';
import 'package:haider/services/firestoreService.dart';
import 'package:haider/utills/customToast.dart';

class CurrentUserInfoController extends GetxController {
  AuthController authController = Get.find();
  var selectedIndex = 0.obs;
  var Id = ''.obs;
  var currentUserId = ''.obs;
  FirestoreService firestoreService = FirestoreService();
  var userInfo = UserModel().obs;
  var currentUserInfo = UserModel().obs;
  var isLoading = false.obs;
  var showLoadingBar = false.obs;

  Future<void> getUserInfo() async {
    isLoading(true);
    var userInfoNew = await firestoreService.getUserInfo(Id.value);
    userInfo.value = userInfoNew;
    //CustomToast.showToast('userId ${userInfoNew.currentUserId}');

    isLoading(false);
  }

  Future<void> getCurrentUserInfo() async {
    // CustomToast.showToast(authController.currentUserId.value);

    showLoadingBar(true);
    var userInfoNew =
        await firestoreService.getUserInfo(authController.currentUserId.value);
    currentUserInfo.value = userInfoNew;

    showLoadingBar(false);
  }

  @override
  void onInit() {
   
    getUserInfo();
    getCurrentUserInfo();
    super.onInit();
  }
}
