import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haider/controllers/getSellAndBuyPropertController.dart';
import 'package:haider/utills/customColors.dart';
import 'package:haider/views/addDataScreen.dart';
import '../../currentUserPropertyDetail.dart';

class SellView extends StatelessWidget {
  final GetSellAndBuyPropertyController getSellPropertyController =
      Get.put(GetSellAndBuyPropertyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.orangeColor,
        child: Text('+'),
        onPressed: () {
          Get.to(AddDataScreen(value: 'sale'));
        },
      ),
      body: Obx(() {
        if (getSellPropertyController.isLoading == true) {
          return Center(child: CircularProgressIndicator());
        } else {
          return getSellPropertyController
                      .currentUserSellinglist.value.length ==
                  0
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
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: getSellPropertyController
                          .currentUserSellinglist.value.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                  Get.to(CurrentUserPropertyDetail(
                                      data: getSellPropertyController
                                          .currentUserSellinglist[index]));
                                },
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  getSellPropertyController
                                                      .currentUserSellinglist[
                                                          index]
                                                      .images[0],
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Center(
                                                      child: Icon(Icons.error)),
                                            ),
                                            getSellPropertyController
                                                        .currentUserSellinglist[
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
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Sold Out',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
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
                                              .currentUserSellinglist[index]
                                              .address,
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: Text(
                                          '${getSellPropertyController.currentUserSellinglist[index].city[0].toUpperCase()}${getSellPropertyController.currentUserSellinglist[index].city.substring(1).toLowerCase()}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.greyColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Price',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '${getSellPropertyController.currentUserSellinglist[index].price} Rs',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      CustomColors.orangeColor),
                                            )
                                          ],
                                        ),
                                      )
                                    ])));
                      }),
                );
        }
      }),
    );
  }
}
