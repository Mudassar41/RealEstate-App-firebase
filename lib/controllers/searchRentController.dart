import 'package:get/get.dart';
import 'package:haider/controllers/rentAndRentOutController.dart';
import 'package:haider/models/propertyModel.dart';
import 'package:haider/services/firestoreService.dart';

class SearchRentController extends GetxController {
  final RentAndRentOutController rentAndRentOutController = Get.find();
  var rentSerachList = <PropertyModel>[].obs;
  FirestoreService firestoreService = FirestoreService();
  var isLoading = false.obs;


  Future<void> searchRentList() async {
    isLoading(true);
    var list = await firestoreService.serachRentList(
        rentAndRentOutController.cityEditTextController.text,
        rentAndRentOutController.rangeTextFromController.text,
        rentAndRentOutController.rangeTextToTextController.text);
    rentSerachList.value = list;
    isLoading(false);
  }

  @override
  void refresh() {
    // TODO: implement refresh
    searchRentList();
    super.refresh();
  }
}
