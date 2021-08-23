import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/authController.dart';
import 'package:haider/models/propertyModel.dart';
import 'package:haider/services/firestoreService.dart';
import 'package:haider/utills/customToast.dart';

class GetSellAndBuyPropertyController extends GetxController {
  final AuthController controller=Get.find();

  var value = true.obs;

  final cityEditTextController=TextEditingController();
  final rangeTextFromController=TextEditingController();
  final rangeTextToTextController=TextEditingController();


  FirestoreService firestoreService = FirestoreService();
  var currentUserSellinglist = <PropertyModel>[].obs;
  var allBuyList=<PropertyModel>[].obs;
  var isLoading = false.obs;

  getSellProprtyOfCurrentUser() async {
    isLoading(true);
    var newList = await firestoreService.getCurrentUserPropertyForSelling();
    currentUserSellinglist.value = newList;
    isLoading(false);
  }
  getAllBuyingProperty() async {
    isLoading(true);
    var newList = await firestoreService.getAllBuyingList();
    allBuyList.value = newList;
    isLoading(false);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSellProprtyOfCurrentUser();
    getAllBuyingProperty();

  }
  // @override
  // void refresh() {
  //   // TODO: implement refresh
  //   super.refresh();
  // //  CustomToast.showToast('refreshed');
  //   getSellProprtyOfCurrentUser();
  //   getAllBuyingProperty();
  // }

}
