import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/draweController.dart';
import 'package:haider/controllers/pageViewController.dart';
import 'package:haider/utills/customColors.dart';

class Home extends StatelessWidget {
  final PageViewController pageViewController = Get.put(PageViewController());
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: pageViewController.activityList.map((data) {
                int index = pageViewController.activityList.indexOf(data);
                return Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          pageViewController.pageViewIndex.value = index;
                          controller.jumpToPage(
                              pageViewController.pageViewIndex.value);
                        },
                        child: Obx(() {
                          return Container(
                            height: 35,
                            decoration: BoxDecoration(
                                color: pageViewController.pageViewIndex.value ==
                                        index
                                    ? CustomColors.orangeColor
                                    : Colors.white,
                                border: Border.all(
                                    width: 1.5,
                                    color: pageViewController
                                                .pageViewIndex.value ==
                                            index
                                        ? CustomColors.orangeColor
                                        : CustomColors.greyColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: Text(
                                data,
                                style: TextStyle(
                                    fontWeight: pageViewController
                                                .pageViewIndex.value ==
                                            index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: pageViewController
                                                .pageViewIndex.value ==
                                            index
                                        ? Colors.white
                                        : CustomColors.greyColor),
                              ),
                            ),
                          );
                        }),
                      ),
                    ));
              }).toList()),
        ),
        Expanded(
            child: PageView(
          onPageChanged: (index) {
            pageViewController.pageViewIndex.value = index;
          },
          children: pageViewController.pageViewItems,
          controller: controller,
        ))
      ],
    ));
  }
}
