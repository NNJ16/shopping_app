import 'package:flutter/cupertino.dart';
import '../services/supplier_service.dart';

class SupplierDTO extends ChangeNotifier {
  final String supplierId;
  final String supplierName;
  final String supplierAddress;
  final String imgPath;
  final String supplierItem;
  final String supplierQuantity;

  SupplierDTO(
      {required this.supplierName,
      required this.supplierId,
      required this.imgPath,
      required this.supplierAddress,
      required this.supplierItem,
      required this.supplierQuantity});

  Future<List<SupplierDTO>> getSuppliersByCategoryOrSerachFor(String element) {
    if (element == "allSuppliers") {
      notifyListeners();
      return SupplierService.getAllSuppliers();
    }else {
      notifyListeners();
      return SupplierService.getSuppliersLikeName(element);
    }
  }
}




  // Future<List<SupplierDTO>> getSuppliersByCategoryOrSerachFor(String element) {
  //   if (element == "allItems") {
  //     notifyListeners();
  //     return SupplierService.getAllSuppliers();
  //   } else if (categoryStringList.contains(element)) {
  //     notifyListeners();
  //     return SupplierService.getItemsByCategory(element);
  //   } else {
  //     notifyListeners();
  //     return SupplierService.getItemsLikeName(element);
  //   }
  // }