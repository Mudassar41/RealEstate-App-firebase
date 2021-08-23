import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/currentUserInfoController.dart';
import 'package:haider/controllers/sqfliteController.dart';
import 'package:haider/models/propertyModel.dart';
import 'package:haider/utills/customColors.dart';

class PropertyDetail extends StatelessWidget {
  final PropertyModel data;

  PropertyDetail({required this.data});

  final CurrentUserInfoController controller =
      Get.put(CurrentUserInfoController());
  final SqfliliteController sqfliliteController =
      Get.put(SqfliliteController());
  @override
  Widget build(BuildContext context) {
    sqfliliteController.getLIkiedOnly(data.docId);
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
                child: Stack(children: [
                  PageView(
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
                  Positioned(
                      top: 5,
                      right: 5,
                      child: Obx(() {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.black26, shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.favorite,
                                // ignore: unrelated_type_equality_checks
                                color: sqfliliteController.isLiked.value == true
                                    ? CustomColors.orangeColor
                                    : Colors.white,
                              ),
                              onPressed: () async {
                                sqfliliteController.likePropertyModel
                                    .likeProprtyId = data.docId;

                                String res = await sqfliliteController
                                    .sqfliteService
                                    .addToLike(
                                        sqfliliteController.likePropertyModel);

                                if (res == 'added') {
                                  print("added");
                                } else {
                                  print("removed");
                                }

                                // bool value = await sqfliliteController
                                //     .sqfliteService
                                //     .LikedPropertyonly(data.docId);
                                sqfliliteController.getLIkiedOnly(data.docId);
                                //  print(value);
                              },
                            ),
                          ),
                        );
                      }))
                ]),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
                child: Text(
                  'Listing Agent',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.orangeColor),
                ),
              ),
              Obx(() {
                if (controller.isLoading.value == true) {
                  return CircularProgressIndicator();
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 10, right: 15, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${controller.userInfo.value.firstName[0].toUpperCase()}${controller.userInfo.value.firstName.substring(1).toLowerCase()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                                Text(
                                  ' ${controller.userInfo.value.lastName[0].toUpperCase()}${controller.userInfo.value.lastName.substring(1).toLowerCase()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                            Text(controller.userInfo.value.phoneNumber)
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              FlutterPhoneDirectCaller.callNumber(
                                  controller.userInfo.value.phoneNumber);
                            },
                            icon: Icon(Icons.phone))
                      ],
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
