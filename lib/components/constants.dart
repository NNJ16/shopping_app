import 'package:flutter/material.dart';

import '../model/category.dart';

const kPrimaryColor = Color(0xFF2AAF63);
const kSecondaryColor = Color(0xFFF3F5F7);

const categoryStringList = <String>[
  "Vegetables",
  "Fruits",
  "Meat",
  "Fish",
  "Bevarages",
];

const categoryList = [
  Category(
      category: "All Items",
      url:
          "https://5.imimg.com/data5/SELLER/Default/2021/2/BF/YL/GY/54285427/all-grocery-items-500x500.png"),
  Category(
      category: "Vegetables",
      url:
          "https://www.transparentpng.com/thumb/vegetables/all-fruits-and-vegetables-in-basket-background-transparent-veD4qx.png"),
  Category(
      category: "Fruits",
      url:
          "https://images.news18.com/ibnlive/uploads/2022/01/fresh-fruits.jpg"),
  Category(
      category: "Meat",
      url:
          "https://static.wikia.nocookie.net/recipes/images/1/19/Meats.jpg/revision/latest?cb=20080516004309"),
  Category(
      category: "Fish",
      url:
          "https://5.imimg.com/data5/WI/ZZ/OL/ANDROID-81993397/product-jpeg-250x250.jpg"),
  Category(
      category: "Bevarages",
      url:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXDBe92knKUTT6xu3wO7FPa35oCy2v13yGJTQuzrKD9SdA-3wFp92qPtxa9JefOC1omrA&usqp=CAU")
];
