import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/authController.dart';
import 'package:haider/controllers/draweController.dart';
import 'package:haider/controllers/pageViewController.dart';
import 'package:haider/utills/customColors.dart';

class NavDrawerScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final DraweController draweController = Get.put(DraweController());
  final PageViewController pageViewController = Get.put(PageViewController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
            child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 200,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    // shrinkWrap: true,
                    itemCount: draweController.drawerItemsList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          draweController.drawerItemsList[index].icon,
                          color: draweController.selectedDrawerIndex == index
                              ? CustomColors.orangeColor
                              : CustomColors.greyColor,
                        ),
                        title: Text(
                          draweController.drawerItemsList[index].title,
                          style: TextStyle(
                              fontWeight:
                                  draweController.selectedDrawerIndex == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              color:
                                  draweController.selectedDrawerIndex == index
                                      ? CustomColors.orangeColor
                                      : CustomColors.greyColor),
                        ),
                        onTap: () {
                          print(index);
                          draweController.selectedDrawerIndex.value = index;
                          draweController.update();
                          pageViewController.pageViewIndex.value = 0;
                          Navigator.pop(context);
                        },
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: CustomColors.orangeColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: ListTile(
                      leading: Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Log Out',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        authController.currentUser(false);
                        authController.update();
                        pageViewController.pageViewIndex.value = 0;
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          color: Colors.white,
        )),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          // centerTitle: true,
          title: Obx(() {
            return Text(
              draweController.selectedDrawerIndex.value == 2
                  ? 'Account Setting'
                  : 'APNAGHAR.COM',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColors.greyColor,
                  fontSize: 22),
            );
          }),
          actions: [
            // IconButton(
            //     onPressed: () {},
            //     icon: Icon(Icons.notifications_none_outlined)),
            //  Icon(Icons.logout_outlined,size: 22,)
          ],
        ),
        body: Obx(() {
          return IndexedStack(
            index: draweController.selectedDrawerIndex.value,
            children: draweController.drawerChildrens.value,
          );
        }),
      ),
    );
  }
}
