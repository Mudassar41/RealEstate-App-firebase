import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/rentAndRentOutController.dart';
import 'package:haider/utills/customColors.dart';

import '../../addDataScreen.dart';
import '../../currentUserPropertyDetail.dart';

class RentOutView extends StatelessWidget {
  // const RentOutView({Key key}) : super(key: key);
  final RentAndRentOutController rentOutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColors.orangeColor,
          child: Text('+'),
          onPressed: () {
            Get.to(AddDataScreen(value: 'rent'));
          },
        ),
        body: Obx(() {
          if (rentOutController.isLoading == true) {
            return Center(child: CircularProgressIndicator());
          } else {
            return rentOutController.currentUserRentOutlist.value.length == 0
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
                        itemCount: rentOutController
                            .currentUserRentOutlist.value.length,
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
                                        data: rentOutController
                                            .currentUserRentOutlist[index]));
                                  },
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: rentOutController
                                                .currentUserRentOutlist[index]
                                                .images[0],
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              height: 150,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
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
                                            errorWidget:
                                                (context, url, error) => Center(
                                                    child: Icon(Icons.error)),
                                          ),
                                          rentOutController
                                                      .currentUserRentOutlist[
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
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        'Rented',
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
                                        rentOutController
                                            .currentUserRentOutlist[index]
                                            .address,
                                        textAlign: TextAlign.left,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Text(
                                        '${rentOutController.currentUserRentOutlist[index].city[0].toUpperCase()}${rentOutController.currentUserRentOutlist[index].city.substring(1).toLowerCase()}',
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
                                            'Rent',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            '${rentOutController.currentUserRentOutlist[index].price} Rs',
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
        }));
  }
}
