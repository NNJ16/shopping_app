import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/dto/supplier_dto.dart';

import '../model/supplier.dart';

class SupplierService {
  static CollectionReference suppliers =
      FirebaseFirestore.instance.collection('suppliers');

  static Future<String> addSupplier(Supplier supplier) {
    return suppliers.add({
      'supplierName': supplier.supplierName,
      'supplierAddress': supplier.supplierAddress,
      'supplierItem': supplier.supplierItem,
      'imgPath': supplier.imgPath,
      'supplierQuantity': supplier.supplierQuantity
      
    }).then((value) {
          print(supplier.supplierName);
                    print(supplier.supplierAddress);

          print(supplier.supplierItem);

          print(supplier.imgPath);
          print(supplier.supplierQuantity);


      return value.id;
    }).catchError((error) => "");
  }

  static Future<bool> editSupplier(Supplier supplier, String id) {
    return suppliers.doc(id).update({
      'supplierName': supplier.supplierName,
      'supplierAddress': supplier.supplierAddress,
      'supplierItem': supplier.supplierItem,
      'imgPath': supplier.imgPath,
      'supplierQuantity': supplier.supplierQuantity
    }).then((value) {
      return true;
    }).catchError((error) => false);
  }

  static Future<List<SupplierDTO>> getAllSuppliers() async {
    List<SupplierDTO> supplierList = [];
    await suppliers
        // .where("accountId", isEqualTo: accountId)
        .orderBy("supplierName", descending: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        SupplierDTO supplier = SupplierDTO(
            supplierId: doc.id,
            supplierName: doc["supplierName"],
            supplierAddress: doc["supplierAddress"],
            supplierItem: doc["supplierItem"],
            supplierQuantity: doc["supplierQuantity"],
            imgPath: doc["imgPath"]);
        supplierList.add(supplier);
      }
    }).catchError((error) {
      print(error);
    });
    print(supplierList);
    return supplierList;
  }

  static Future<List<SupplierDTO>> getSuppliersLikeName(String searchKey) async {
    List<SupplierDTO> supplierList = [];
    await suppliers
        .where('supplierName', isGreaterThanOrEqualTo: searchKey)
        .where('supplierName', isLessThan: searchKey + 'z')
        .orderBy("supplierName", descending: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        SupplierDTO supplier = SupplierDTO(
            supplierId: doc.id,
            supplierName: doc["supplierName"],
            supplierAddress: doc["supplierAddress"],
            supplierItem: doc["supplierItem"],
            supplierQuantity: doc["supplierQuantity"],
            imgPath: doc["imgPath"]);
        supplierList.add(supplier);
      }
    }).catchError((error) {
      print(error);
    });
    return supplierList;
  }


  static Future<bool> deleteSupplier(String id) {
    return suppliers
        .doc(id)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }


}
