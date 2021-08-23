import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/views/drawerViews/homeViewsitems/buyView.dart';
import 'package:haider/views/drawerViews/homeViewsitems/rentOutView.dart';
import 'package:haider/views/drawerViews/homeViewsitems/rentView.dart';
import 'package:haider/views/drawerViews/homeViewsitems/sellView.dart';

class PageViewController extends GetxController {
  var activityList = [
    'Buy',
    'Rent',
    'Rent Out',
    'Sell',
  ];

  var pageViewIndex = 0.obs;
  var pageViewItems = [
    BuyView(),
    RentView(),
    RentOutView(),
    SellView(),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
