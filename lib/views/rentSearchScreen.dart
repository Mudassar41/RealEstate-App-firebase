import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/getSellAndBuyPropertController.dart';
import 'package:haider/controllers/rentAndRentOutController.dart';
import 'package:haider/controllers/searchRentController.dart';
import 'package:haider/controllers/serachController.dart';
import 'package:haider/utills/customColors.dart';
import 'package:haider/utills/customToast.dart';

class RentSearchScreen extends StatelessWidget {
  final RentAndRentOutController rentAndRentOutController = Get.find();
  final SearchRentController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        actions: [
          Icon(Icons.filter_alt_outlined),
        ],
        title: Text(
          'Apply Filters',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: TextField(
                  controller: rentAndRentOutController.cityEditTextController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: 'Filter By City'),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Price Range',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: TextField(
                          controller:
                          rentAndRentOutController.rangeTextFromController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: 'From'),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        flex: 1,
                        child: TextField(
                          controller:
                          rentAndRentOutController.rangeTextToTextController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: 'To'),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (rentAndRentOutController.cityEditTextController.text ==
                        '' &&
                        rentAndRentOutController.rangeTextFromController.text ==
                            '' &&
                        rentAndRentOutController.rangeTextToTextController.text ==
                            '') {
                      CustomToast.showToast('Fill Any One Field');
                    } else {
                      rentAndRentOutController.value(false);
                      controller.update();
                      Get.back();
                    }
                  },
                  child: Text('Apply'),
                  style: ElevatedButton.styleFrom(
                      primary: CustomColors.orangeColor,
                      minimumSize: Size(100, 40)),
                ),
              )
            ],
          )),
    );
  }
}
