import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyModel {
  late Timestamp timestamp;
  late String action;
  late String docId;
  late String currentUserId;
  late String propertyType;
  late String propertyFor;
  late String city;
  late String area;
  late String address;
  late String size;
  late String bedrooms;
  late String bathrooms;
  late String kitchen;
  late String descr;
  late String price;
  late List images;

  PropertyModel(); // PropertyModel();

  PropertyModel.getFromServer(
      this.timestamp,
      this.action,
      this.docId,
      this.currentUserId,
      this.propertyType,
      this.propertyFor,
      this.city,
      this.area,
      this.address,
      this.size,
      this.bedrooms,
      this.bathrooms,
      this.kitchen,
      this.descr,
      this.price,
      this.images);
}
