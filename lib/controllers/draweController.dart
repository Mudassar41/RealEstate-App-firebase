import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/drawerItems.dart';
import 'package:haider/views/drawerViews/homeView.dart';
import 'package:haider/views/drawerViews/homeViewsitems/accountSetttings.dart';
import 'package:haider/views/drawerViews/homeViewsitems/buyView.dart';
import 'package:haider/views/drawerViews/homeViewsitems/rentOutView.dart';
import 'package:haider/views/drawerViews/homeViewsitems/rentView.dart';
import 'package:haider/views/drawerViews/homeViewsitems/sellView.dart';
import 'package:haider/views/likedPropertyScreen.dart';

class DraweController extends GetxController {
  var selectedDrawerIndex = 0.obs;
  var drawerItemsList = <DrawerItem>[
    DrawerItem(title: 'Home', icon: Icons.home_outlined),
    DrawerItem(title: 'Liked Property ', icon: Icons.favorite_outline),
    DrawerItem(title: 'Account Settings', icon: Icons.settings_outlined),
  ].obs;
  var drawerChildrens = [Home(), LikedProperty(), AccountSettings()].obs;
}
