import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:haider/controllers/currentUserInfoController.dart';
import 'package:haider/utills/customColors.dart';

class AccountSettings extends StatelessWidget {
  final CurrentUserInfoController currentUserInfoController =
      Get.put(CurrentUserInfoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: CustomColors.orangeColor,
        child: Icon(Icons.edit_outlined),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0.0,
      ),
      body: Obx(() {
        if (currentUserInfoController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children: [
              Image.asset(
                'assets/images/logo.png',
                // color: Colors.white,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, right: 20, left: 8, bottom: 8),
                      child: Icon(
                        Icons.person_outline,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                        ),
                        Text(
                          '${currentUserInfoController.currentUserInfo.value.firstName[0].toUpperCase()}${currentUserInfoController.currentUserInfo.value.firstName.substring(1).toLowerCase()} ${currentUserInfoController.currentUserInfo.value.lastName[0].toUpperCase()}${currentUserInfoController.currentUserInfo.value.lastName.substring(1).toLowerCase()}  ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, right: 20, left: 8, bottom: 8),
                      child: Icon(
                        Icons.phone_android_outlined,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone',
                        ),
                        Text(
                          '${currentUserInfoController.currentUserInfo.value.phoneNumber}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
