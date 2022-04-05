import 'package:flutter/cupertino.dart';
import '../components/constants.dart';
import '../services/item_service.dart';

class ItemDTO extends ChangeNotifier {
  final String itemId;
  final String itemName;
  final String itemDescription;
  final String itemcategory;
  final double itemPrice;
  final String imgPath;
  final String itemAmount;

  ItemDTO(
      {required this.itemcategory,
      required this.itemId,
      required this.imgPath,
      required this.itemName,
      required this.itemAmount,
      required this.itemDescription,
      required this.itemPrice});

  Future<List<ItemDTO>> getItemsByCategoryOrSerachFor(String element) {
    if (element == "allItems") {
      notifyListeners();
      return ItemService.getAllItems();
    } else if (categoryStringList.contains(element)) {
      notifyListeners();
      return ItemService.getItemsByCategory(element);
    } else {
      notifyListeners();
      return ItemService.getItemsLikeName(element);
    }
  }
}
