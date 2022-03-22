class ItemDTO{
  final String itemId;
  final String itemName;
  final String itemDescription;
  final String itemcategory;
  final double itemPrice;
  final String imgPath;
  final String itemAmount;

  ItemDTO({required this.itemcategory, required this.itemId, required this.imgPath, required this.itemName, required this.itemAmount, required this.itemDescription, required this.itemPrice});

}