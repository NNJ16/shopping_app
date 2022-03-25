import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/dto/item_dto.dart';

import '../model/item.dart';

class ItemService {
  static CollectionReference items =
      FirebaseFirestore.instance.collection('items');

  static Future<String> addItem(Item item) {
    return items.add({
      'itemName': item.itemName,
      'itemDescription': item.itemDescription,
      'itemCategory': item.itemCategory,
      'imgPath': item.imgPath,
      'itemPrice': item.itemPrice,
      'itemAmount': item.itemAmount
    }).then((value) {
      return value.id;
    }).catchError((error) => "");
  }

  static Future<bool> editItem(Item item, String id) {
    return items.doc(id).update({
      'itemName': item.itemName,
      'itemDescription': item.itemDescription,
      'itemCategory': item.itemCategory,
      'imgPath': item.imgPath,
      'itemPrice': item.itemPrice,
      'itemAmount': item.itemAmount
    }).then((value) {
      return true;
    }).catchError((error) => false);
  }

  static Future<List<ItemDTO>> getAllItems() async {
    List<ItemDTO> itemList = [];
    await items
        // .where("accountId", isEqualTo: accountId)
        .orderBy("itemName", descending: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        ItemDTO item = ItemDTO(
            itemId: doc.id,
            itemName: doc["itemName"],
            itemDescription: doc["itemDescription"],
            itemcategory: doc["itemCategory"],
            itemAmount: doc["itemAmount"],
            itemPrice: doc["itemPrice"],
            imgPath: doc["imgPath"]);
        itemList.add(item);
      }
    }).catchError((error) {
      print(error);
    });
    return itemList;
  }

  static Future<List<ItemDTO>> getItemsLikeName(String searchKey) async {
    List<ItemDTO> itemList = [];
    await items
        .where('itemName', isGreaterThanOrEqualTo: searchKey)
        .where('itemName', isLessThan: searchKey + 'z')
        .orderBy("itemName", descending: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        ItemDTO item = ItemDTO(
            itemId: doc.id,
            itemName: doc["itemName"],
            itemDescription: doc["itemDescription"],
            itemcategory: doc["itemCategory"],
            itemAmount: doc["itemAmount"],
            itemPrice: doc["itemPrice"],
            imgPath: doc["imgPath"]);
        itemList.add(item);
      }
    }).catchError((error) {
      print(error);
    });
    return itemList;
  }

  static Future<List<ItemDTO>> getItemsByCategory(String category) async {
    List<ItemDTO> itemList = [];
    await items
        .where('itemCategory', isEqualTo: category)
        .orderBy("itemName", descending: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        ItemDTO item = ItemDTO(
            itemId: doc.id,
            itemName: doc["itemName"],
            itemDescription: doc["itemDescription"],
            itemcategory: doc["itemCategory"],
            itemAmount: doc["itemAmount"],
            itemPrice: doc["itemPrice"],
            imgPath: doc["imgPath"]);
        itemList.add(item);
      }
    }).catchError((error) {
      print(error);
    });
    return itemList;
  }

  static Future<bool> deleteItem(String id) {
    return items
        .doc(id)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }
}
