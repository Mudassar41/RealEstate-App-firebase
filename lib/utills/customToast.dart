import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'customColors.dart';

class CustomToast {
  static showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: CustomColors.orangeColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
