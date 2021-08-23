import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/currentUserInfoController.dart';
import 'package:haider/controllers/getSellAndBuyPropertController.dart';
import 'package:haider/controllers/rentAndRentOutController.dart';
import 'package:haider/models/propertyModel.dart';
import 'package:haider/utills/customColors.dart';
import 'package:haider/utills/customToast.dart';

class CurrentUserPropertyDetail extends StatelessWidget {
  final PropertyModel data;

  CurrentUserPropertyDetail({required this.data});

  final CurrentUserInfoController controller =
      Get.put(CurrentUserInfoController());
  final GetSellAndBuyPropertyController getSellAndBuyPropertyController =
      Get.find();
  final RentAndRentOutController rentAndRentOutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 220,
                child: PageView(
                    onPageChanged: (index) {
                      controller.selectedIndex.value = index;
                    },
                    scrollDirection: Axis.horizontal,
                    children: data.images.map((e) {
                      return CachedNetworkImage(
                        imageUrl: e,
                        imageBuilder: (context, imageProvider) => Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          clipBehavior: Clip.antiAlias,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.error)),
                      );
                    }).toList()),
              ),
              Obx(() {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: data.images.map((e) {
                      int index = data.images.indexOf(e);
                      //controller.selectedIndex.value = index;
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              color: controller.selectedIndex.value == index
                                  ? CustomColors.orangeColor
                                  : Colors.black54,
                              shape: BoxShape.circle),
                        ),
                      );
                    }).toList());
              }),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${data.price} Rs',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: CustomColors.orangeColor),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                '${data.city[0].toUpperCase()}${data.city.substring(1).toLowerCase()}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              Text(data.area),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                child: Text(
                  data.address,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                child: Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                child: Text(
                  data.descr,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                child: Text(
                  'Additional Information',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                child: Row(
                  children: [
                    Icon(Icons.bed_outlined),
                    Text(
                      ' ${data.bedrooms} Bedrooms',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                child: Row(
                  children: [
                    Icon(Icons.bathtub_outlined),
                    Text(
                      ' ${data.bathrooms} Bathrooms',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                child: Row(
                  children: [
                    Icon(Icons.kitchen_outlined),
                    Text(
                      ' ${data.kitchen} Kitchen',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                child: Row(
                  children: [
                    Icon(Icons.crop_square_outlined),
                    Text(
                      ' ${data.size} Sqft',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                child: data.action == 'Sold Out' || data.action == 'Rented'
                    ? Obx(() {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: controller.showLoadingBar.value == true
                              ? Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: CustomColors.greyColor),
                                  onPressed: () async {
                                    controller.showLoadingBar(true);
                                    String response =
                                        await getSellAndBuyPropertyController
                                            .firestoreService
                                            .deleteProperty(
                                                data.docId, data.images);
                                    if (response == 'Property Deleted') {
                                      getSellAndBuyPropertyController
                                          .getAllBuyingProperty();
                                      getSellAndBuyPropertyController
                                          .getSellProprtyOfCurrentUser();
                                      controller.showLoadingBar(false);
                                      Get.back();
                                      CustomToast.showToast('Property Deleted');
                                    } else {
                                      CustomToast.showToast(response);
                                      controller.showLoadingBar(false);
                                      Get.back();
                                    }
                                  },
                                  child: Text('Delete Property'),
                                ),
                        );
                      })
                    : Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: CustomColors.orangeColor),
                                  onPressed: () async {
                                    String updateValue;
                                    if (data.propertyFor == 'rent') {
                                      updateValue = 'Rented';
                                    } else {
                                      updateValue = 'Sold Out';
                                    }
                                    String response =
                                        await getSellAndBuyPropertyController
                                            .firestoreService
                                            .updateProperty(
                                                data.docId, updateValue);
                                    if (response == 'Data Updated') {
                                      getSellAndBuyPropertyController
                                          .getAllBuyingProperty();
                                      getSellAndBuyPropertyController
                                          .getSellProprtyOfCurrentUser();
                                      rentAndRentOutController
                                          .getAllRentProperty();
                                      rentAndRentOutController
                                          .getRentOutProprtyOfCurrentUser();
                                      Get.back();
                                      CustomToast.showToast('Changes Saved');
                                    } else {
                                      CustomToast.showToast(response);
                                      Get.back();
                                    }
                                  },
                                  child: Text(data.propertyFor == 'sale'
                                      ? 'Mark Sold Out'
                                      : 'Mark Rented'),
                                ),
                              )),
                          Expanded(child: Obx(() {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: controller.showLoadingBar.value == true
                                  ? Center(child: CircularProgressIndicator())
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: CustomColors.greyColor),
                                      onPressed: () async {
                                        controller.showLoadingBar(true);
                                        String response =
                                            await getSellAndBuyPropertyController
                                                .firestoreService
                                                .deleteProperty(
                                                    data.docId, data.images);
                                        if (response == 'Property Deleted') {
                                          getSellAndBuyPropertyController
                                              .getAllBuyingProperty();
                                          getSellAndBuyPropertyController
                                              .getSellProprtyOfCurrentUser();
                                          rentAndRentOutController
                                              .getAllRentProperty();
                                          rentAndRentOutController
                                              .getRentOutProprtyOfCurrentUser();
                                          controller.showLoadingBar(false);
                                          Get.back();
                                          CustomToast.showToast(
                                              'Property Deleted');
                                        } else {
                                          CustomToast.showToast(response);
                                          controller.showLoadingBar(false);
                                          Get.back();
                                        }
                                      },
                                      child: Text('Delete Property'),
                                    ),
                            );
                          }))
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
