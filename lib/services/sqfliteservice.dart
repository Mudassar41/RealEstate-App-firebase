import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haider/models/likePropertyModel.dart';
import 'package:haider/models/propertyModel.dart';
import 'package:haider/utills/customToast.dart';
import 'package:haider/views/likedPropertyScreen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteService {
  Future<Database> openDb() async {
    Database _database = await openDatabase(
      join(await getDatabasesPath(), 'Property.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE LikedProperty(p_id TEXT PRIMARY KEY)",
        );
      },
      version: 1,
    );
    return _database;
  }

  Future<void> inserPropert(LikePropertyModel likePropertyModel) async {
    final db = await openDb();
    await db.insert(
      'LikedProperty',
      likePropertyModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> LikedPropertyonly(String Id) async {
    bool onlyLike;
    final Database db = await openDb();
    var result =
        await db.query("LikedProperty", where: "p_id=?", whereArgs: [Id]);
    if (result.length > 0) {
      onlyLike = true;
    } else {
      onlyLike = false;
    }
    //  print(onlyLike);
    return onlyLike;
  }

  Future<String> addToLike(LikePropertyModel model) async {
    String res = '';
    final Database db = await openDb();
    var result = await db.query("LikedProperty",
        where: "p_id=?", whereArgs: [model.likeProprtyId]);

    if (result.length == 0) {
      await db.insert(
        'LikedProperty',
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      res = 'added';
    } else {
      await db.delete(
        'LikedProperty',
        where: "p_id = ?",
        whereArgs: [model.likeProprtyId],
      );
      res = 'removed';
    }
    return res;
  }

  Future<List<PropertyModel>> Getdata() async {
    // List<LikePropertyModel> dataList = [];
    List<PropertyModel> propertyList = [];

    final Database db = await openDb();
    var Values = await db.query('LikedProperty');
    PropertyModel propertyModel;
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('property').get();

    snapshot.docs.forEach((document) {
      propertyModel = PropertyModel.getFromServer(
          document.get('time'),
          document.get('propertyAction'),
          document.id,
          document.get('currentUserId'),
          document.get('propertyType'),
          document.get('propertyFor'),
          document.get('city'),
          document.get('area'),
          document.get('address'),
          document.get('size'),
          document.get('bedrooms'),
          document.get('bathrooms'),
          document.get('kitchen'),
          document.get('des'),
          document.get('price'),
          document.get('images'));
      CustomToast.showToast(document.id);

      Values.forEach((i) {
        // dataList = LikePropertyModel.getData(i['phone_id'].toString());
        if (i['p_id'] == document.id) {
          propertyList.add(propertyModel);
          //  CustomToast.showToast('${propertyList.length}');
        }
      });
    });
    CustomToast.showToast('${propertyList.length}');
    return propertyList;
  }
}
// await FirebaseFirestore.instance
      //     .collection('property')
      //     .doc(i['p_id'].toString())
      //     .get()
      //     .then((DocumentSnapshot document) {
      //   if (document.exists) {
      //     PropertyModel propertyModel = PropertyModel.getFromServer(
      //         document.get('time'),
      //         document.get('propertyAction'),
      //         document.id,
      //         document.get('currentUserId'),
      //         document.get('propertyType'),
      //         document.get('propertyFor'),
      //         document.get('city'),
      //         document.get('area'),
      //         document.get('address'),
      //         document.get('size'),
      //         document.get('bedrooms'),
      //         document.get('bathrooms'),
      //         document.get('kitchen'),
      //         document.get('des'),
      //         document.get('price'),
      //         document.get('images'));

      //     dataList.add(propertyModel);
      //     res = 'Yes data exists';
      //   }
      // });