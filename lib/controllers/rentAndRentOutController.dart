import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/propertyModel.dart';
import 'package:haider/services/firestoreService.dart';

import 'authController.dart';

class RentAndRentOutController extends GetxController {
  final AuthController controller=Get.find();
  FirestoreService firestoreService = FirestoreService();
  var currentUserRentOutlist = <PropertyModel>[].obs;
  var allRentList = <PropertyModel>[].obs;
  var isLoading = false.obs;
  var value = true.obs;
/////////////////////////////////////////////////////
  final cityEditTextController=TextEditingController();
  final rangeTextFromController=TextEditingController();
  final rangeTextToTextController=TextEditingController();
  //////////////////////////////////////////////////

  getRentOutProprtyOfCurrentUser() async {
    isLoading(true);
    var newList = await firestoreService.getCurrentUserPropertyForRentOut();
    currentUserRentOutlist.value = newList;
    isLoading(false);
  }

  getAllRentProperty() async {
    isLoading(true);
    var newList = await firestoreService.getAllRentList();
    allRentList.value = newList;
    isLoading(false);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getRentOutProprtyOfCurrentUser();
    getAllRentProperty();
  }
  // @override
  // void refresh() {
  //   // TODO: implement refresh
  //   super.refresh();
  //   getRentOutProprtyOfCurrentUser();
  //   getAllRentProperty();
  // }
}
