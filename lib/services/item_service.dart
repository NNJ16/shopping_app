import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/item.dart';

class ItemService{
  static CollectionReference items =
      FirebaseFirestore.instance.collection('items');

  static Future<String> addItem(Item item) {
    return items
        .add({
          'itemName': item.itemName,
          'itemDescription': item.itemDescription,
          'imgPath': item.imgPath,
          'itemPrice': item.itemPrice,
          'itemAmount': item.itemAmount
        })
        .then((value) {
          return value.id;
        })
        .catchError((error) => "");
  }
}