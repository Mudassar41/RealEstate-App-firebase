import 'package:get/get.dart';
import 'package:haider/controllers/getSellAndBuyPropertController.dart';
import 'package:haider/models/propertyModel.dart';
import 'package:haider/services/firestoreService.dart';

class SerachController extends GetxController {
  final GetSellAndBuyPropertyController controller = Get.find();

  var buySerachList = <PropertyModel>[].obs;
  FirestoreService firestoreService = FirestoreService();
  var isLoading = false.obs;

  Future<void> serachBuy() async {
 //  CustomToast.showToast(controller.cityEditTextController.text);
    isLoading(true);
    var list = await firestoreService.serachBuyList(
        controller.cityEditTextController.text,
        controller.rangeTextFromController.text,
        controller.rangeTextToTextController.text);
    buySerachList.value = list;
    isLoading(false);
  }

  @override
  void refresh() {
    // TODO: implement refresh
    serachBuy();
    super.refresh();
  }
}
