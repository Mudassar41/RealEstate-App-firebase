import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/currentUserInfoController.dart';
import 'package:haider/controllers/getSellAndBuyPropertController.dart';
import 'package:haider/controllers/serachController.dart';
import 'package:haider/controllers/sqfliteController.dart';
import 'package:haider/utills/customColors.dart';
import 'package:haider/views/serchScreen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../propertyDetailScreen.dart';

class BuyView extends StatelessWidget {
  final GetSellAndBuyPropertyController getSellPropertyController =
      Get.put(GetSellAndBuyPropertyController());

  final SerachController serachController = Get.put(SerachController());
  final CurrentUserInfoController userInfoController =
      Get.put(CurrentUserInfoController());

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (getSellPropertyController.isLoading == true) {
        return Center(child: CircularProgressIndicator());
      } else {
        return getSellPropertyController.allBuyList.value.length == 0
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
                                Get.to(SearchScreen());
                              },
                              child: Container(
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      getSellPropertyController.value.value ==
                                              true
                                          ? Icon(Icons.search_outlined)
                                          : IconButton(
                                              icon: Icon(
                                                  Icons.arrow_back_outlined),
                                              onPressed: () {
                                                getSellPropertyController
                                                    .value(true);
                                                getSellPropertyController
                                                    .cityEditTextController
                                                    .clear();
                                                getSellPropertyController
                                                    .rangeTextFromController
                                                    .clear();
                                                getSellPropertyController
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
                      getSellPropertyController.value.value == true
                          ? GridView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: getSellPropertyController
                                  .allBuyList.value.length,
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
                                              getSellPropertyController
                                                  .allBuyList[index]
                                                  .currentUserId;
                                          userInfoController.getUserInfo();
                                          Get.to(PropertyDetail(
                                              data: getSellPropertyController
                                                  .allBuyList[index]));
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
                                                          getSellPropertyController
                                                              .allBuyList[index]
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
                                                    getSellPropertyController
                                                                .allBuyList[
                                                                    index]
                                                                .action ==
                                                            'Sold Out'
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
                                                                  'Sold Out',
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
                                                  getSellPropertyController
                                                      .allBuyList[index]
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
                                                  '${getSellPropertyController.allBuyList[index].city[0].toUpperCase()}${getSellPropertyController.allBuyList[index].city.substring(1).toLowerCase()}',
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
                                                      '${getSellPropertyController.allBuyList[index].price} Rs',
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
                              if (serachController.isLoading.value == true) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return serachController
                                            .buySerachList.value.length ==
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
                                        itemCount: serachController
                                            .buySerachList.value.length,
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
                                                        data: serachController
                                                                .buySerachList[
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
                                                                imageUrl: serachController
                                                                    .buySerachList[
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
                                                              serachController
                                                                          .buySerachList[
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
                                                            serachController
                                                                .buySerachList[
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
                                                            '${serachController.buySerachList[index].city[0].toUpperCase()}${serachController.buySerachList[index].city.substring(1).toLowerCase()}',
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
                                                                '${serachController.buySerachList[index].price} Rs',
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
