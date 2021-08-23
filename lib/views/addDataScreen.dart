import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/currentUserInfoController.dart';
import 'package:haider/controllers/getSellAndBuyPropertController.dart';
import 'package:haider/controllers/rentAndRentOutController.dart';
import 'package:haider/utills/customToast.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:haider/controllers/addpropertyController.dart';
import 'package:haider/utills/customColors.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddDataScreen extends StatelessWidget {
  final String value;

  AddDataScreen({required this.value});

  final AddPropertyController controller = Get.put(AddPropertyController());
  final GetSellAndBuyPropertyController sellPropertyController =
      Get.put(GetSellAndBuyPropertyController());
  final RentAndRentOutController rentAndRentOutController = Get.find();
  final CurrentUserInfoController currentUserInfoController =
      Get.put(CurrentUserInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
            child: Form(
          key: controller.propertyFormKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add property',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.orangeColor,
                        fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Enter property details to listed on APNAGHAR.COM',
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                'Type of Property',
                style: TextStyle(
                    fontSize: 18,
                    color: CustomColors.greyColor,
                    fontWeight: FontWeight.bold),
              ),
              Obx(() {
                return Column(
                    children: controller.values.value.map(
                  (value) {
                    final selected = controller.selectedValue.value == value;
                    final color = selected
                        ? controller.selectedColor.value
                        : controller.unSelectedColor.value;

                    return RadioListTile<String>(
                        value: value,
                        groupValue: controller.selectedValue.value,
                        title: Text(
                          value,
                          style: TextStyle(color: color),
                        ),
                        activeColor: controller.selectedColor.value,
                        onChanged: (value) =>
                            controller.selectedValue.value = value!);
                  },
                ).toList());
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Select City',
                  style: TextStyle(
                      fontSize: 18,
                      color: CustomColors.greyColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 8, bottom: 2),
                  child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: CustomColors.orangeColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.location_city_outlined,
                              color: Colors.black54,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${controller.selectedCity.value[0].toUpperCase()}${controller.selectedCity.value.substring(1).toLowerCase()}',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  showCitiesListDialog(context);
                                },
                                icon: Icon(Icons.arrow_drop_down))
                          ],
                        ),
                      ))),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Select Area',
                  style: TextStyle(
                      fontSize: 18,
                      color: CustomColors.greyColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 8, bottom: 2),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.areaEditTextController,
                  keyboardType: TextInputType.text,
                  cursorColor: CustomColors.orangeColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: '',
                    focusedErrorBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    errorBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    focusedBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    labelText: 'Area',
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.scatter_plot_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    if (value == '' || value == null) return 'Area  required';
                  },
                  onSaved: (value) {
                    controller.propertyModel.area = value.toString();
                    //authController.userModel.userEmail = value.toString();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Address',
                  style: TextStyle(
                      fontSize: 18,
                      color: CustomColors.greyColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 8, bottom: 2),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.addressEditTextController,
                  keyboardType: TextInputType.text,
                  cursorColor: CustomColors.orangeColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: '',
                    focusedErrorBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    errorBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    focusedBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    labelText: 'Address',
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    if (value == '' || value == null)
                      return 'Address  required';
                  },
                  onSaved: (value) {
                    controller.propertyModel.address = value.toString();
                    //authController.userModel.userEmail = value.toString();
                  },
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Size',
                      style: TextStyle(
                          fontSize: 18,
                          color: CustomColors.greyColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 8, bottom: 2),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.sizeEditTextController,
                      keyboardType: TextInputType.number,
                      cursorColor: CustomColors.orangeColor,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: '',
                        focusedErrorBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(
                                color: CustomColors.orangeColor)),
                        errorBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(
                                color: CustomColors.orangeColor)),
                        enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(
                                color: CustomColors.orangeColor)),
                        focusedBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(
                                color: CustomColors.orangeColor)),
                        labelText: 'Size in Sqft',
                        labelStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.photo_size_select_small_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value) {
                        if (value == '' || value == null)
                          return 'Area  required';
                      },
                      onSaved: (value) {
                        controller.propertyModel.size = value.toString();
                        //authController.userModel.userEmail = value.toString();
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Bedrooms',
                  style: TextStyle(
                      fontSize: 18,
                      color: CustomColors.greyColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 8, bottom: 2),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.bedroomsEditTextController,
                  keyboardType: TextInputType.number,
                  cursorColor: CustomColors.orangeColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: '',
                    focusedErrorBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    errorBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    focusedBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    labelText: 'No of Bedrooms',
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.bed_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    if (value == '' || value == null)
                      return 'No of Bedrooms  required';
                  },
                  onSaved: (value) {
                    controller.propertyModel.bedrooms = value.toString();
                    //authController.userModel.userEmail = value.toString();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Bathrooms',
                  style: TextStyle(
                      fontSize: 18,
                      color: CustomColors.greyColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 8, bottom: 2),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.bathroomsTextController,
                  keyboardType: TextInputType.number,
                  cursorColor: CustomColors.orangeColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: '',
                    focusedErrorBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    errorBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    focusedBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    labelText: 'No of Bathrooms',
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.bathroom_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    if (value == '' || value == null)
                      return 'No of Bathrooms required';
                  },
                  onSaved: (value) {
                    controller.propertyModel.bathrooms = value.toString();
                    //authController.userModel.userEmail = value.toString();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Kitchen',
                  style: TextStyle(
                      fontSize: 18,
                      color: CustomColors.greyColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 8, bottom: 2),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.kitchenEditTextController,
                  keyboardType: TextInputType.number,
                  cursorColor: CustomColors.orangeColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: '',
                    focusedErrorBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    errorBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    focusedBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    labelText: 'No of Kitchens',
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.kitchen_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    if (value == '' || value == null)
                      return 'No of Kitchens required';
                  },
                  onSaved: (value) {
                    controller.propertyModel.kitchen = value.toString();
                    //authController.userModel.userEmail = value.toString();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Description',
                  style: TextStyle(
                      fontSize: 18,
                      color: CustomColors.greyColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 8, bottom: 2),
                child: TextFormField(
                  maxLines: 5,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.desEditTextController,
                  keyboardType: TextInputType.text,
                  cursorColor: CustomColors.orangeColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: '',
                    focusedErrorBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    errorBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    focusedBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: (value) {
                    if (value == '' || value == null)
                      return 'Detailed Description required';
                  },
                  onSaved: (value) {
                    controller.propertyModel.descr = value.toString();
                    //authController.userModel.userEmail = value.toString();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value == 'sale' ? 'Price' : 'Rent/month',
                  style: TextStyle(
                      fontSize: 18,
                      color: CustomColors.greyColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 8, bottom: 2),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.priceEditTextController,
                  keyboardType: TextInputType.number,
                  cursorColor: CustomColors.orangeColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: '',
                    focusedErrorBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    errorBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    focusedBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide:
                            new BorderSide(color: CustomColors.orangeColor)),
                    labelText: value == 'sale' ? 'Price' : 'rent',
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.label_important_outline,
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    if (value == '' || value == null) return 'Price required';
                  },
                  onSaved: (value) {
                    controller.propertyModel.price = value.toString();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(100, 40),
                        primary: CustomColors.orangeColor),
                    child: Text("Select Images"),
                    onPressed: () {
                      controller.getImage();
                    }),
              ),
              Obx(() {
                return controller.images.value.isEmpty
                    ? Container(
                        height: 0,
                        width: 0,
                      )
                    : Padding(
                        padding:
                            const EdgeInsets.only(left: 22, right: 22, top: 8),
                        child: GridView.count(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: List.generate(
                              controller.images.value.length, (index) {
                            Asset asset = controller.images.value[index];
                            print(asset.getByteData(quality: 100));
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: AssetThumb(
                                  asset: asset,
                                  width: 300,
                                  height: 300,
                                ),
                              ),
                            );
                          }),
                        ),
                      );
              }),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: controller.showLoadingBar == false
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(200, 50),
                              primary: CustomColors.greyColor),
                          child: Text("Save Property"),
                          onPressed: () async {
                            if (controller.images.value.isEmpty) {
                              CustomToast.showToast('Please Select images');
                            } else {
                              if (!controller.propertyFormKey.currentState!
                                  .validate()) {
                                return;
                              } else {
                                controller.propertyModel.city =
                                    controller.selectedCity.value;
                                controller.propertyModel.propertyType =
                                    controller.selectedValue.value;
                                controller.propertyFormKey.currentState!.save();
                                controller.showLoadingBar(true);
                                String response = await controller
                                    .firestoreService
                                    .addproprtyToDatabase(
                                        controller.propertyModel,
                                        controller.images.value,
                                        value);
                                if (response == 'Data added') {
                                  controller.showLoadingBar(false);
                                  CustomToast.showToast('Proprty Added');
                                  sellPropertyController
                                      .getSellProprtyOfCurrentUser();

                                  rentAndRentOutController.getAllRentProperty();

                                  rentAndRentOutController
                                      .getRentOutProprtyOfCurrentUser();

                                  sellPropertyController.getAllBuyingProperty();
                                  currentUserInfoController.getUserInfo();
                                  controller.areaEditTextController.clear();
                                  controller.addressEditTextController.clear();
                                  controller.sizeEditTextController.clear();
                                  controller.bedroomsEditTextController.clear();
                                  controller.bathroomsTextController.clear();
                                  controller.kitchenEditTextController.clear();
                                  controller.desEditTextController.clear();
                                  controller.priceEditTextController.clear();
                                  controller.images.value = [];
                                  Get.back();
                                } else {
                                  controller.showLoadingBar(false);
                                  CustomToast.showToast('Something went wrong');
                                }
                              }
                            }
                          })
                      : CircularProgressIndicator(
                          color: CustomColors.orangeColor,
                        ),
                );
              }),
            ],
          ),
        )));
  }

  Future<void> showCitiesListDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text(
              'Select City',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                Text(""),
                Obx(() {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.citieslist.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              String cityname =
                                  controller.citieslist[index].cityname;
                              controller.selectedCity.value == cityname;

                              print(controller.selectedCity(cityname));
                              print("yes");
                              Navigator.pop(context);
                            },
                            child: Text(
                              '${controller.citieslist[index].cityname[0].toUpperCase()}${controller.citieslist[index].cityname.substring(1).toLowerCase()}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      });
                }),
              ],
            )));
      },
    );
  }
}
