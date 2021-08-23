import 'package:get/get.dart';
import 'package:haider/controllers/currentUserInfoController.dart';
import 'package:haider/models/likePropertyModel.dart';
import 'package:haider/models/propertyModel.dart';
import 'package:haider/services/sqfliteservice.dart';

class SqfliliteController extends GetxController {
  var isLoading = true.obs;
  SqfliteService sqfliteService = SqfliteService();
  LikePropertyModel likePropertyModel = LikePropertyModel();
  var isLiked = false.obs;
  var dataList = <PropertyModel>[].obs;
  CurrentUserInfoController currentUserInfoController =
      Get.put(CurrentUserInfoController());

  @override
  void onInit() {
    //getData();
    sqfliteService.Getdata();
    super.onInit();
  }

  getLIkiedOnly(String Id) async {
    var value = await sqfliteService.LikedPropertyonly(Id);
    print(value);
    isLiked(value);
  }

  // getData() async {
  //   isLoading(true);
  //   var list = await sqfliteService.Getdata();
  //   print('length is ${list.length}');
  //   dataList.value = list;
  //   isLoading(false);
  // }
}
