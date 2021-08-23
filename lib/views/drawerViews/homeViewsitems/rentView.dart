import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/currentUserInfoController.dart';
import 'package:haider/controllers/rentAndRentOutController.dart';
import 'package:haider/controllers/searchRentController.dart';
import 'package:haider/utills/customColors.dart';

import '../../propertyDetailScreen.dart';
import '../../rentSearchScreen.dart';

class RentView extends StatelessWidget {
  final RentAndRentOutController rentAndRentOutController =
      Get.put(RentAndRentOutController());
  final CurrentUserInfoController userInfoController =
      Get.put(CurrentUserInfoController());
  final SearchRentController searchRentController =
      Get.put(SearchRentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (rentAndRentOutController.isLoading == true) {
        return Center(child: CircularProgressIndicator());
      } else {
        return rentAndRentOutController.allRentList.value.length == 0
            ? Center(
                child: Text(
                  "No Data Found",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.orangeColor),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(5.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.to(RentSearchScreen());
                              },
                              child: Container(
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      rentAndRentOutController.value.value ==
                                              true
                                          ? Icon(Icons.search_outlined)
                                          : IconButton(
                                              icon: Icon(
                                                  Icons.arrow_back_outlined),
                                              onPressed: () {
                                                rentAndRentOutController
                                                    .value(true);
                                                rentAndRentOutController
                                                    .cityEditTextController
                                                    .clear();
                                                rentAndRentOutController
                                                    .rangeTextFromController
                                                    .clear();
                                                rentAndRentOutController
                                                    .rangeTextToTextController
                                                    .clear();
                                              },
                                            ),
                                      Center(child: Text(''))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      rentAndRentOutController.value.value == true
                          ? GridView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: rentAndRentOutController
                                  .allRentList.value.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio:
                                    MediaQuery.of(context).size.height / 1100,
                              ),
                              itemBuilder: (context, index) {
                                return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    elevation: 3,
                                    child: InkWell(
                                        splashColor: Colors.green,
                                        onTap: () {
                                          userInfoController.Id.value =
                                              rentAndRentOutController
                                                  .allRentList[index]
                                                  .currentUserId;
                                          userInfoController.getUserInfo();
                                          Get.to(PropertyDetail(
                                              data: rentAndRentOutController
                                                  .allRentList[index]));
                                        },
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Stack(
                                                  children: [
                                                    CachedNetworkImage(
                                                      imageUrl:
                                                          rentAndRentOutController
                                                              .allRentList[
                                                                  index]
                                                              .images[0],
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        height: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Center(
                                                              child: Icon(
                                                                  Icons.error)),
                                                    ),
                                                    rentAndRentOutController
                                                                .allRentList[
                                                                    index]
                                                                .action ==
                                                            'Rented'
                                                        ? Positioned(
                                                            top: 5,
                                                            left: 5,
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: CustomColors
                                                                      .orangeColor,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10))),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                  'Rented',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ))
                                                        : Container(
                                                            height: 0,
                                                            width: 0,
                                                          )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Text(
                                                  rentAndRentOutController
                                                      .allRentList[index]
                                                      .address,
                                                  textAlign: TextAlign.left,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Text(
                                                  '${rentAndRentOutController.allRentList[index].city[0].toUpperCase()}${rentAndRentOutController.allRentList[index].city.substring(1).toLowerCase()}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Row(
                                                  //  mainAxisAlignment:
                                                  //   MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Text(
                                                      'Price',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '${rentAndRentOutController.allRentList[index].price} Rs',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: CustomColors
                                                              .orangeColor),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ])));
                              })
                          : Obx(() {
                              if (searchRentController.isLoading.value ==
                                  true) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return searchRentController.rentSerachList.value.length ==
                                        0
                                    ? Center(
                                        child: Text(
                                        'No Data Found',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.orangeColor),
                                      ))
                                    : GridView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemCount: searchRentController
                                            .rentSerachList.value.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio:
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  1100,
                                        ),
                                        itemBuilder: (context, index) {
                                          return Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                              elevation: 3,
                                              child: InkWell(
                                                  splashColor: Colors.green,
                                                  onTap: () {
                                                    Get.to(PropertyDetail(
                                                        data: searchRentController
                                                                .rentSerachList[
                                                            index]));
                                                  },
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Stack(
                                                            children: [
                                                              CachedNetworkImage(
                                                                imageUrl: searchRentController
                                                                    .rentSerachList[
                                                                        index]
                                                                    .images[0],
                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                  height: 150,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Center(
                                                                        child: Icon(
                                                                            Icons.error)),
                                                              ),
                                                              searchRentController
                                                                          .rentSerachList[
                                                                              index]
                                                                          .action ==
                                                                      'Sold Out'
                                                                  ? Positioned(
                                                                      top: 5,
                                                                      left: 5,
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                CustomColors.orangeColor,
                                                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            'Sold Out',
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      ))
                                                                  : Container(
                                                                      height: 0,
                                                                      width: 0,
                                                                    )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5,
                                                                  right: 5),
                                                          child: Text(
                                                            searchRentController
                                                                .rentSerachList[
                                                                    index]
                                                                .address,
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5,
                                                                  right: 5),
                                                          child: Text(
                                                            '${searchRentController.rentSerachList[index].city[0].toUpperCase()}${searchRentController.rentSerachList[index].city.substring(1).toLowerCase()}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5,
                                                                  right: 5),
                                                          child: Row(
                                                            //  mainAxisAlignment:
                                                            //   MainAxisAlignment.spaceAround,
                                                            children: [
                                                              Text(
                                                                'Price',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                '${searchRentController.rentSerachList[index].price} Rs',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: CustomColors
                                                                        .orangeColor),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ])));
                                        });
                              }
                            })
                    ],
                  ),
                ),
              );
      }
    }));
  }
}
