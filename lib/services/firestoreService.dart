import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/authController.dart';
import 'package:haider/models/cityModel.dart';
import 'package:haider/models/propertyModel.dart';
import 'package:haider/models/userModel.dart';
import 'package:haider/utills/customToast.dart';
import 'package:multi_image_picker/src/asset.dart';
import 'package:path/path.dart' as path;

class FirestoreService {
  var currentUser = FirebaseAuth.instance.currentUser;
  final AuthController controller = Get.find();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference property =
      FirebaseFirestore.instance.collection('property');

//Adding user Data to FireStore Database
  Future<void> addUserToFireStore(UserModel userModel) async {
    CustomToast.showToast('Adding data');
    await users
        .add({
          'firstName': userModel.firstName.toString(),
          'LastName': userModel.lastName.toString(),
          'userId': userModel.currentUserId.toString(),
          'phoneNo': userModel.phoneNumber.toString(),
          'userEmail': userModel.userEmail.toString(),
        })
        .then((value) => CustomToast.showToast('added '))
        .catchError((error) => CustomToast.showToast('error'));
  }

//Adding propert To FireStore Databse
  Future<String> addproprtyToDatabase(
      PropertyModel propertyModel, List images, String typeFor) async {
    List imageUrls = [];
    propertyModel.images = images;
    propertyModel.currentUserId = currentUser!.uid;

    propertyModel.propertyFor = typeFor;
    for (int i = 0; i < propertyModel.images.length; i++) {
      //   var fileExtension = path.extension(propertyModel.images[i].path);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      var firebaseStorageRef =
          FirebaseStorage.instance.ref().child('RealState/$fileName');

      await firebaseStorageRef
          .putData((await propertyModel.images[i].getByteData())
              .buffer
              .asUint8List())
          .then((result) {
        print('Uploaded');
      }).catchError((erorr) {
        print("Error in Uploading");
      });

      String url = await firebaseStorageRef.getDownloadURL();
      if (url != null) {
        print(url);
      }
      imageUrls.add(url);
    }
    Timestamp time = Timestamp.now();
    String response = '';
    await property.add({
      'currentUserId': propertyModel.currentUserId.toString(),
      'propertyFor': propertyModel.propertyFor.toString(),
      'propertyType': propertyModel.propertyType.toString(),
      'city': propertyModel.city.toString(),
      'area': propertyModel.area.toString(),
      'size': propertyModel.size.toString(),
      'bedrooms': propertyModel.bedrooms.toString(),
      'address': propertyModel.address.toString(),
      'bathrooms': propertyModel.bathrooms.toString(),
      'kitchen': propertyModel.kitchen.toString(),
      'des': propertyModel.descr.toString(),
      'price': propertyModel.price.toString(),
      'images': imageUrls,
      'propertyAction': 'None'.toString(),
      'time': time
    }).then((value) {
      response = 'Data added';
    }).catchError((error) {
      response = 'error occured';
    });
    return response;
  }

//

//Get Cities Data
  Future<List<CityModel>> getcitiesList() async {
    List<CityModel> citiesList = [];
    await FirebaseFirestore.instance
        .collection('cities')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc['cityName']);
        CityModel cityModel = CityModel(doc["cityName"]);
        citiesList.add(cityModel);
      });
    });
    return citiesList;
  }

  //Get Propert Of CurrentUser For Selling

  Future<List<PropertyModel>> getCurrentUserPropertyForSelling() async {
    List<PropertyModel> propertyList = [];
    await FirebaseFirestore.instance
        .collection('property')
        .orderBy('time', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("Document Id is ${doc.id}");
        String docId = doc.id;
        PropertyModel propertyModel = PropertyModel.getFromServer(
          doc['time'],
          doc['propertyAction'],
          docId,
          doc['currentUserId'],
          doc['propertyType'],
          doc['propertyFor'],
          doc['city'],
          doc['area'],
          doc['address'],
          doc['size'],
          doc['bedrooms'],
          doc['bathrooms'],
          doc['kitchen'],
          doc['des'],
          doc['price'],
          doc['images'],
        );
        if (doc['currentUserId'] == controller.currentUserId.value &&
            doc['propertyFor'] == 'sale') {
          propertyList.add(propertyModel);
        }
      });
    });
    return propertyList;
  }

  Future<List<PropertyModel>> getAllBuyingList() async {
    List<PropertyModel> propertyList = [];
    await FirebaseFirestore.instance
        .collection('property')
        .orderBy('time', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        PropertyModel propertyModel = PropertyModel.getFromServer(
          doc['time'],
          doc['propertyAction'],
          doc.id,
          doc['currentUserId'],
          doc['propertyType'],
          doc['propertyFor'],
          doc['city'],
          doc['area'],
          doc['address'],
          doc['size'],
          doc['bedrooms'],
          doc['bathrooms'],
          doc['kitchen'],
          doc['des'],
          doc['price'],
          doc['images'],
        );
        if (doc['propertyFor'] == 'sale') {
          propertyList.add(propertyModel);
        }
      });
    });
    return propertyList;
  }

  Future<List<PropertyModel>> getCurrentUserPropertyForRentOut() async {
    // CustomToast.showToast(controller.currentUserId.value);
    List<PropertyModel> propertyList = [];
    await FirebaseFirestore.instance
        .collection('property')
        .orderBy('time', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        PropertyModel propertyModel = PropertyModel.getFromServer(
          doc['time'],
          doc['propertyAction'],
          doc.id,
          doc['currentUserId'],
          doc['propertyType'],
          doc['propertyFor'],
          doc['city'],
          doc['area'],
          doc['address'],
          doc['size'],
          doc['bedrooms'],
          doc['bathrooms'],
          doc['kitchen'],
          doc['des'],
          doc['price'],
          doc['images'],
        );
        if (doc['currentUserId'] == controller.currentUserId.value &&
            doc['propertyFor'] == 'rent') {
          propertyList.add(propertyModel);
        }
      });
    });
    return propertyList;
  }

  Future<List<PropertyModel>> getAllRentList() async {
    List<PropertyModel> propertyList = [];
    await FirebaseFirestore.instance
        .collection('property')
        .orderBy('time', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        PropertyModel propertyModel = PropertyModel.getFromServer(
          doc['time'],
          doc['propertyAction'],
          doc.id,
          doc['currentUserId'],
          doc['propertyType'],
          doc['propertyFor'],
          doc['city'],
          doc['area'],
          doc['address'],
          doc['size'],
          doc['bedrooms'],
          doc['bathrooms'],
          doc['kitchen'],
          doc['des'],
          doc['price'],
          doc['images'],
        );
        if (doc['propertyFor'] == 'rent') {
          propertyList.add(propertyModel);
        }
      });
    });
    return propertyList;
  }

  Future<UserModel> getUserInfo(String id) async {
    //  dynamic currentUserId = FirebaseAuth.instance.currentUser!.uid;
    //CustomToast.showToast(id);
    UserModel newUserModel = UserModel();
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        UserModel userModel = UserModel();
        if (doc['userId'] == id) {
          userModel.currentUserId = doc['userId'];
          userModel.firstName = doc['firstName'];
          print('user name is ${userModel.firstName}');
          userModel.lastName = doc['LastName'];
          userModel.phoneNumber = doc['phoneNo'];

          newUserModel = userModel;
        }
      });
    });
    return newUserModel;
  }

  Future<String> updateProperty(String docID, String updatedValue) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('property');
    String response = '';
    await collectionReference
        .doc(docID)
        .update({'propertyAction': updatedValue.toString()})
        .then((value) => response = 'Data Updated')
        .catchError((error) => response = "Failed to update user: $error");

    return response;
  }

  Future<String> deleteProperty(String docID, List images) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('property');
    String response = '';

    for (int i = 0; i < images.length; i++) {
      var storageReference =
          await FirebaseStorage.instance.refFromURL(images[i]);

      await storageReference.delete();

      print('image deleted');
    }
    await collectionReference
        .doc(docID)
        .delete()
        .then((value) => response = 'Property Deleted')
        .catchError((error) => response = "Failed to Delete Property: $error");

    return response;
  }

  Future<List<PropertyModel>> serachBuyList(
      String cityname, String priceFrom, String priceTo) async {
    List<PropertyModel> propertyList = [];

    if (cityname != '' && priceFrom == '' && priceTo == '') {
      //   CustomToast.showToast('controller.cityEditTextController.text');
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('time', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel = PropertyModel.getFromServer(
            doc['time'],
            doc['propertyAction'],
            doc.id,
            doc['currentUserId'],
            doc['propertyType'],
            doc['propertyFor'],
            doc['city'],
            doc['area'],
            doc['address'],
            doc['size'],
            doc['bedrooms'],
            doc['bathrooms'],
            doc['kitchen'],
            doc['des'],
            doc['price'],
            doc['images'],
          );
          String city = doc['city'];

          if (doc['propertyFor'] == 'sale' &&
              cityname.toLowerCase() == city.toLowerCase()) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname != '' && priceFrom != '' && priceTo == '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel = PropertyModel.getFromServer(
            doc['time'],
            doc['propertyAction'],
            doc.id,
            doc['currentUserId'],
            doc['propertyType'],
            doc['propertyFor'],
            doc['city'],
            doc['area'],
            doc['address'],
            doc['size'],
            doc['bedrooms'],
            doc['bathrooms'],
            doc['kitchen'],
            doc['des'],
            doc['price'],
            doc['images'],
          );
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'sale' &&
              cityname.toLowerCase() == city.toLowerCase() &&
              price >= int.parse(priceFrom)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname != '' && priceFrom == '' && priceTo != '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel = PropertyModel.getFromServer(
            doc['time'],
            doc['propertyAction'],
            doc.id,
            doc['currentUserId'],
            doc['propertyType'],
            doc['propertyFor'],
            doc['city'],
            doc['area'],
            doc['address'],
            doc['size'],
            doc['bedrooms'],
            doc['bathrooms'],
            doc['kitchen'],
            doc['des'],
            doc['price'],
            doc['images'],
          );
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'sale' &&
              cityname.toLowerCase() == city.toLowerCase() &&
              price <= int.parse(priceTo)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname != '' && priceFrom != '' && priceTo != '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel = PropertyModel.getFromServer(
            doc['time'],
            doc['propertyAction'],
            doc.id,
            doc['currentUserId'],
            doc['propertyType'],
            doc['propertyFor'],
            doc['city'],
            doc['area'],
            doc['address'],
            doc['size'],
            doc['bedrooms'],
            doc['bathrooms'],
            doc['kitchen'],
            doc['des'],
            doc['price'],
            doc['images'],
          );
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'sale' &&
              cityname.toLowerCase() == city.toLowerCase() &&
              price >= int.parse(priceFrom) &&
              price <= int.parse(priceTo)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname == '' && priceFrom != '' && priceTo == '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel = PropertyModel.getFromServer(
            doc['time'],
            doc['propertyAction'],
            doc.id,
            doc['currentUserId'],
            doc['propertyType'],
            doc['propertyFor'],
            doc['city'],
            doc['area'],
            doc['address'],
            doc['size'],
            doc['bedrooms'],
            doc['bathrooms'],
            doc['kitchen'],
            doc['des'],
            doc['price'],
            doc['images'],
          );
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'sale' && price >= int.parse(priceFrom)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname == '' && priceFrom == '' && priceTo != '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel = PropertyModel.getFromServer(
            doc['time'],
            doc['propertyAction'],
            doc.id,
            doc['currentUserId'],
            doc['propertyType'],
            doc['propertyFor'],
            doc['city'],
            doc['area'],
            doc['address'],
            doc['size'],
            doc['bedrooms'],
            doc['bathrooms'],
            doc['kitchen'],
            doc['des'],
            doc['price'],
            doc['images'],
          );

          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'sale' && price <= int.parse(priceTo)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname == '' && priceFrom != '' && priceTo != '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel = PropertyModel.getFromServer(
            doc['time'],
            doc['propertyAction'],
            doc.id,
            doc['currentUserId'],
            doc['propertyType'],
            doc['propertyFor'],
            doc['city'],
            doc['area'],
            doc['address'],
            doc['size'],
            doc['bedrooms'],
            doc['bathrooms'],
            doc['kitchen'],
            doc['des'],
            doc['price'],
            doc['images'],
          );
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'sale' &&
              price >= int.parse(priceFrom) &&
              price <= int.parse(priceTo)) {
            propertyList.add(propertyModel);
          }
        });
      });
    }

    return propertyList;
  }

////////////////////////////////////////////////////////////////////////
  Future<List<PropertyModel>> serachRentList(
      String cityname, String priceFrom, String priceTo) async {
    List<PropertyModel> propertyList = [];

    if (cityname != '' && priceFrom == '' && priceTo == '') {
      //   CustomToast.showToast('controller.cityEditTextController.text');
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('time', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel = PropertyModel.getFromServer(
            doc['time'],
            doc['propertyAction'],
            doc.id,
            doc['currentUserId'],
            doc['propertyType'],
            doc['propertyFor'],
            doc['city'],
            doc['area'],
            doc['address'],
            doc['size'],
            doc['bedrooms'],
            doc['bathrooms'],
            doc['kitchen'],
            doc['des'],
            doc['price'],
            doc['images'],
          );
          String city = doc['city'];

          if (doc['propertyFor'] == 'rent' &&
              cityname.toLowerCase() == city.toLowerCase()) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname != '' && priceFrom != '' && priceTo == '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel = PropertyModel.getFromServer(
            doc['time'],
            doc['propertyAction'],
            doc.id,
            doc['currentUserId'],
            doc['propertyType'],
            doc['propertyFor'],
            doc['city'],
            doc['area'],
            doc['address'],
            doc['size'],
            doc['bedrooms'],
            doc['bathrooms'],
            doc['kitchen'],
            doc['des'],
            doc['price'],
            doc['images'],
          );
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'rent' &&
              cityname.toLowerCase() == city.toLowerCase() &&
              price >= int.parse(priceFrom)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname != '' && priceFrom == '' && priceTo != '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel = PropertyModel.getFromServer(
            doc['time'],
            doc['propertyAction'],
            doc.id,
            doc['currentUserId'],
            doc['propertyType'],
            doc['propertyFor'],
            doc['city'],
            doc['area'],
            doc['address'],
            doc['size'],
            doc['bedrooms'],
            doc['bathrooms'],
            doc['kitchen'],
            doc['des'],
            doc['price'],
            doc['images'],
          );
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'rent' &&
              cityname.toLowerCase() == city.toLowerCase() &&
              price <= int.parse(priceTo)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname != '' && priceFrom != '' && priceTo != '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel = PropertyModel.getFromServer(
            doc['time'],
            doc['propertyAction'],
            doc.id,
            doc['currentUserId'],
            doc['propertyType'],
            doc['propertyFor'],
            doc['city'],
            doc['area'],
            doc['address'],
            doc['size'],
            doc['bedrooms'],
            doc['bathrooms'],
            doc['kitchen'],
            doc['des'],
            doc['price'],
            doc['images'],
          );
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'rent' &&
              cityname.toLowerCase() == city.toLowerCase() &&
              price >= int.parse(priceFrom) &&
              price <= int.parse(priceTo)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname == '' && priceFrom != '' && priceTo == '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel = PropertyModel.getFromServer(
            doc['time'],
            doc['propertyAction'],
            doc.id,
            doc['currentUserId'],
            doc['propertyType'],
            doc['propertyFor'],
            doc['city'],
            doc['area'],
            doc['address'],
            doc['size'],
            doc['bedrooms'],
            doc['bathrooms'],
            doc['kitchen'],
            doc['des'],
            doc['price'],
            doc['images'],
          );
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'rent' && price >= int.parse(priceFrom)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname == '' && priceFrom == '' && priceTo != '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel = PropertyModel.getFromServer(
            doc['time'],
            doc['propertyAction'],
            doc.id,
            doc['currentUserId'],
            doc['propertyType'],
            doc['propertyFor'],
            doc['city'],
            doc['area'],
            doc['address'],
            doc['size'],
            doc['bedrooms'],
            doc['bathrooms'],
            doc['kitchen'],
            doc['des'],
            doc['price'],
            doc['images'],
          );

          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'rent' && price <= int.parse(priceTo)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname == '' && priceFrom != '' && priceTo != '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel = PropertyModel.getFromServer(
            doc['time'],
            doc['propertyAction'],
            doc.id,
            doc['currentUserId'],
            doc['propertyType'],
            doc['propertyFor'],
            doc['city'],
            doc['area'],
            doc['address'],
            doc['size'],
            doc['bedrooms'],
            doc['bathrooms'],
            doc['kitchen'],
            doc['des'],
            doc['price'],
            doc['images'],
          );
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'rent' &&
              price >= int.parse(priceFrom) &&
              price <= int.parse(priceTo)) {
            propertyList.add(propertyModel);
          }
        });
      });
    }

    return propertyList;
  }
}
