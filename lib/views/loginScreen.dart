import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/authController.dart';
import 'package:haider/controllers/currentUserInfoController.dart';
import 'package:haider/controllers/getSellAndBuyPropertController.dart';
import 'package:haider/controllers/rentAndRentOutController.dart';
import 'package:haider/utills/customColors.dart';
import 'package:haider/utills/customToast.dart';
import 'package:haider/views/registerScreen.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final GetSellAndBuyPropertyController getSellAndBuyPropertyController =
      Get.put(GetSellAndBuyPropertyController());
  final RentAndRentOutController rentAndRentOutController =
      Get.put(RentAndRentOutController());
  final CurrentUserInfoController currentUserInfoController =
      Get.put(CurrentUserInfoController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          return Form(
            key: authController.loginFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/logo.png'),
                                fit: BoxFit.fill))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Sign In to Continue",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 8, bottom: 2),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: authController.emailTextEditController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: CustomColors.orangeColor,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        focusedErrorBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(
                                color: CustomColors.orangeColor)),
                        errorBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(
                                color: CustomColors.orangeColor)),
                        enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(
                                color: CustomColors.orangeColor)),
                        focusedBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(
                                color: CustomColors.orangeColor)),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value) {
                        if (value == '' || value == null)
                          return 'email  required';
                      },
                      onSaved: (value) {
                        authController.userModel.userEmail = value.toString();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 8, bottom: 2),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: authController.passwordTextEditController,
                      textInputAction: TextInputAction.done,
                      obscureText: authController.isHidden.value ? true : false,
                      keyboardType: TextInputType.visiblePassword,
                      cursorColor: CustomColors.orangeColor,
                      decoration: InputDecoration(
                          focusedErrorBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: new BorderSide(
                                  color: CustomColors.orangeColor)),
                          errorBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                  color: CustomColors.orangeColor)),
                          enabledBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                  color: CustomColors.orangeColor)),
                          focusedBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                  color: CustomColors.orangeColor)),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.grey),
                          suffixIcon: TextButton(
                              onPressed: () {
                                authController.setVisibility();
                              },
                              child: authController.isHidden.value
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                    )),
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            color: Colors.grey,
                          )),
                      validator: (value) {
                        if (value == '') {
                          return 'Password required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        authController.userModel.userPassword =
                            value.toString();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Forgott Password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 25, right: 25),
                    child: InkWell(
                      onTap: () async {
                        if (!authController.loginFormKey.currentState!
                            .validate()) {
                          return;
                        } else {
                          authController.loginFormKey.currentState!.save();

                          authController.showLoadingDialog(true);

                          String res = await authController.authService
                              .signInUser(authController.userModel);
                          if (res == 'User  signed In  successfully') {
                            var currentUser = FirebaseAuth.instance.currentUser;

                            authController.currentUserId.value =
                                currentUser!.uid;
                            authController.showLoadingDialog(false);
                            authController.currentUser(true);
                            // getSellAndBuyPropertyController.update();
                            // rentAndRentOutController.update();
                            // currentUserInfoController.currentUserId.value=
                            currentUserInfoController.getUserInfo();
                            currentUserInfoController.getCurrentUserInfo();

                            //CustomToast.showToast(res);

                            getSellAndBuyPropertyController
                                .getSellProprtyOfCurrentUser();
                            getSellAndBuyPropertyController
                                .getAllBuyingProperty();

                            rentAndRentOutController
                                .getRentOutProprtyOfCurrentUser();
                            rentAndRentOutController.getAllRentProperty();

                            authController.update();
                          } else {
                            authController.showLoadingDialog(false);
                            authController.currentUser(true);
                            CustomToast.showToast(res);
                            authController.update();
                          }
                        }
                      },
                      child: authController.showLoadingDialog.value == false
                          ? Container(
                              decoration: BoxDecoration(
                                  color: CustomColors.greyColor,
                                  border:
                                      Border.all(color: CustomColors.greyColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                  child: Text(
                                'Sign In',
                                style: TextStyle(color: Colors.white),
                              )))
                          : CircularProgressIndicator(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 25, right: 25),
                    child: InkWell(
                      onTap: () {
                        Get.to(RegisterScreen());
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: CustomColors.lioghtGrey,
                              border:
                                  Border.all(color: CustomColors.lioghtGrey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                              child: Text(
                            'Sign Up',
                            style: TextStyle(color: CustomColors.greyColor),
                          ))),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
