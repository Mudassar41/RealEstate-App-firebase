import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/authController.dart';
import 'package:haider/views/drawerScreen.dart';
import 'package:haider/views/loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.white, // status bar color
  ));
  runApp(MyApp());
}

 class MyApp extends StatelessWidget {
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Candal',
        primarySwatch: Colors.blue,
      ),
      home: Obx(() {
        return authController.currentUser.value == true
            ? NavDrawerScreen()
            : LoginScreen();
      }),
      // home:authController.currentUser.value==true?NavDrawerScreen(): LoginScreen(),
    );
  }
}
